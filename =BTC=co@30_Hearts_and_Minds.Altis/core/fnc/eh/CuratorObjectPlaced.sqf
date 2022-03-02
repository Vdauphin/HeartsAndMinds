
/* ----------------------------------------------------------------------------
Function: btc_eh_fnc_CuratorObjectPlaced

Description:
    Initialise object placed by curator.

Parameters:
    _curator - Curator. [Object]
    _object_placed - Object/Unit placed. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_eh_fnc_CuratorObjectPlaced;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_curator", objNull, [objNull]],
    ["_object_placed", objNull, [objNull]]
];

if !((_object_placed isKindOf "allVehicles") || (_object_placed isKindOf "Module_F")) then {
    [_object_placed] remoteExecCall ["btc_log_fnc_init", 2];

    if (btc_debug_log) then {
        [format ["OBJECT %1", _object_placed], __FILE__, [false]] call btc_debug_fnc_message;
    };
    if (btc_debug) then {
        [str _object_placed, __FILE__, [btc_debug, false]] call btc_debug_fnc_message;
    };
};
