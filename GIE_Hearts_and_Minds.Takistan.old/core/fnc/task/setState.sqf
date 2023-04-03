
/* ----------------------------------------------------------------------------
Function: btc_task_fnc_setState

Description:
    Set state to task and subtasks (children).

Parameters:
    _task - Task ID to change state of the main task and children. [String]
    _state - State to apply. [String]

Returns:
    _isSet - if the state has changed array. [Boolean]

Examples:
    (begin example)
        ["btc_dft", "CANCELED"] call btc_task_fnc_setState;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_task", "", [""]],
    ["_state", "CANCELED", [""]]
];

private _subTasks = _task call BIS_fnc_taskChildren;
if (_subTasks isEqualTo []) then {
    private _taskParent = _task call BIS_fnc_taskParent;
    if (_taskParent isNotEqualTo "") then {
        _task = _taskParent;
        _subTasks = _task call BIS_fnc_taskChildren;
    };
};

([_task] + _subTasks) apply {
    if !(_x call BIS_fnc_taskCompleted) then {
        [_x, _state] call BIS_fnc_taskSetState
    } else {
        false
    };
}
