
/* ----------------------------------------------------------------------------
Function: gie_db_fnc_autoSave

Description:
    Save the current game every hour

Parameters:
    None

Returns:

Examples:
    (begin example)
        [] call gie_db_fnc_autoSave;
    (end)

Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

if (!isServer) exitWith {};

if (isNil "GIE_db_nextSaveTime") then {
    GIE_db_nextSaveTime = time + 30 * 60; 
    ["Init autosave database, waiting for save time", __FILE__, [false, true]] call btc_debug_fnc_message;
};


[{time > GIE_db_nextSaveTime}, {
    ["Saving database", __FILE__, [false, true]] call btc_debug_fnc_message; 
    [] call btc_db_fnc_save;
    GIE_db_nextSaveTime = time + 30 * 60; // 30 minutes
    [format ["Actual save time: %1, next save time: %2", time, GIE_db_nextSaveTime], __FILE__, [false, true]] call btc_debug_fnc_message;
    [] call gie_db_fnc_autoSave;
}] call CBA_fnc_waitUntilAndExecute;