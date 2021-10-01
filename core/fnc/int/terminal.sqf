
/* ----------------------------------------------------------------------------
Function: btc_fnc_int_terminal

Description:
    Fill me when you edit me !

Parameters:
    _terminal - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_int_terminal;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_terminal", objNull, [objNull]],
    ["_terminal_taskID", "", [""]]
];

private _action = ["Open", localize "STR_BTC_HAM_SIDE_HACK_ACEACTION", "\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa", {
    //Start Hacking
    params ["_terminal"];

    [_terminal, 3] call BIS_fnc_dataTerminalAnimate;
    [_terminal getVariable ["btc_terminal_taskID", ""], "SUCCEEDED"] call BIS_fnc_taskSetState;
}, {!(((_this select 0) getVariable ["btc_terminal_taskID", ""]) call BIS_fnc_taskCompleted)}] call ace_interact_menu_fnc_createAction;
[_terminal, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
