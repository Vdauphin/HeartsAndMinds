
/* ----------------------------------------------------------------------------
Function: btc_task_fnc_abort

Description:
    Abort a side mission.

Parameters:
    _task_id - Task ID of the side mission to abort. [String]

Returns:

Examples:
    (begin example)
        ["btc_dft"] call btc_task_fnc_abort;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_task_id", "btc_dft", [""]]
];

if (_task_id isEqualTo "") exitWith {
    localize "STR_BTC_HAM_O_TASK_NOSIDE" call CBA_fnc_notify;
};

if (_task_id in ["btc_m", "btc_dty", "btc_dft"]) exitWith {
    localize "STR_BTC_HAM_O_TASK_NOTASIDE" call CBA_fnc_notify;
};

[_task_id, "CANCELED"] remoteExecCall ["btc_task_fnc_setState", 2];
