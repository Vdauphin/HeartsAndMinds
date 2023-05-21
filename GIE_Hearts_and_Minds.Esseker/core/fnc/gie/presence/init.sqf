/* ----------------------------------------------------------------------------
Function: gie_presence_fnc_init

Description:
    Init discord game presence

Parameters:
    None

Returns:

Examples:
    (begin example)
        [] spawn gie_presence_fnc_init;
    (end)

Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

if (!isClass (configFile >> "CfgPatches" >>  "CAU_DiscordRichPresence")) exitWith {};

[{
    ["Presence update", __FILE__, [btc_debug, btc_debug_log]] call btc_debug_fnc_message;
    [] call gie_presence_fnc_evaluatePresenceContent;
}, 60, player] call CBA_fnc_addPerFrameHandler;