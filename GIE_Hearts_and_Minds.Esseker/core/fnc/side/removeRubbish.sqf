
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_removeRubbish

Description:
    Remove rubbish on road in city with Nemmera.

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_removeRubbish"] spawn btc_side_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

private _minNumberOfSubTask = 2;
private _useful = values btc_city_all select {
    !(_x getVariable ["type", ""] in ["NameMarine", "StrongpointArea"]) &&
    {
        private _city = _x;
        ({
            isOnRoad (_x select 0) ||
            {((_x select 0) nearRoads 6) isNotEqualTo []} // Most IED are just next to road
        } count (_city getVariable ["ieds", []])) >= _minNumberOfSubTask
    }
};
if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
private _city = selectRandom _useful;
private _ieds = (_city getVariable ["ieds", []]) select {
    isOnRoad (_x select 0) ||
    {((_x select 0) nearRoads 6) isNotEqualTo []}
};
private _extra_ied = round random (((count _ieds) - _minNumberOfSubTask) min 2);

[_taskID, 38, objNull, _city getVariable "name"] call btc_task_fnc_create;

private _tasksID = [];
for "_i" from 0 to (_minNumberOfSubTask + _extra_ied - 1) do {
    private _clear_taskID = _taskID + "cl" + str _i;
    _tasksID pushBack _clear_taskID;

    private _selectedIED = _ieds select _i;
    [[_clear_taskID, _taskID], 39, _selectedIED select 0, btc_type_ieds select (btc_model_ieds find (_selectedIED select 1)), false, false] call btc_task_fnc_create;

    ["btc_ied_deleted", {
        params ["_posDeleted_ied"];
        _thisArgs params ["_clear_taskID", "_pos_ied"];

        if (!(_clear_taskID call BIS_fnc_taskCompleted) && {_pos_ied distance _posDeleted_ied < 5}) then {
            [_clear_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
            if (0.5 < random 1) then {
                [_posDeleted_ied] call btc_rep_fnc_call_militia;
            };
        };
    }, [_clear_taskID, _selectedIED select 0]] call CBA_fnc_addEventHandlerArgs;
    ["btc_ied_boom", {
        params ["_posDeleted_ied"];
        _thisArgs params ["_clear_taskID", "_pos_ied"];

        if (!(_clear_taskID call BIS_fnc_taskCompleted) && {_pos_ied distance _posDeleted_ied < 5}) then {
            [_clear_taskID, "FAILED"] call BIS_fnc_taskSetState;
        };
    }, [_clear_taskID, _selectedIED select 0]] call CBA_fnc_addEventHandlerArgs;
};

waitUntil {sleep 5;
    _taskID call BIS_fnc_taskCompleted ||
    !(false in (_tasksID apply {_x call BIS_fnc_taskCompleted}))
};

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};
if !("SUCCEEDED" in (_tasksID apply {_x call BIS_fnc_taskState})) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
};

2 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
