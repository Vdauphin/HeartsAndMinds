
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_kill

Description:
    Your objective is to assassinate a man and bring his dogtag to base for identification.

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_kill"] spawn btc_side_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose an occupied City \\\\
private _useful = values btc_city_all select {
    _x getVariable ["occupied", false] &&
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"])
};

if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};

private _city = selectRandom _useful;

//// Randomise position \\\\
private _houses = ([getPos _city, 100] call btc_fnc_getHouses) select 0;
_houses = _houses select {count (_x buildingPos -1) > 1}; // Building with low enterable positions are not interesting
if (_houses isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};

_houses = _houses apply {[count (_x buildingPos -1), _x]};
_houses sort false;
private _house = objNull;
if (count _houses > 3) then {
    _house = (selectRandom _houses select [0,3]) select 1;
} else {
    _house = _houses select 0 select 1;
};
private _buildingPos = _house buildingPos -1;
_buildingPos = _buildingPos select [0, count _buildingPos min 20];
private _pos_number = count _buildingPos - 1;
private _pos = _buildingPos select (_pos_number - ((round random 1) min _pos_number));

_city setVariable ["spawn_more", true];

//// Officer
private _group_officer = createGroup btc_enemy_side;
_group_officer setVariable ["no_cache", true];
private _officerType = selectRandom btc_type_units;
private _officer = _group_officer createUnit [_officerType, _pos, [], 0, "CAN_COLLIDE"];

//// Data side mission
private _officerName = name _officer;
[_taskID, 25, objNull, [_officerName, _city getVariable "name"]] call btc_task_fnc_create;
private _kill_taskID = _taskID + "ki";
[[_kill_taskID, _taskID], 26, _officer, [_officerName, _city getVariable "name", _officerType]] call btc_task_fnc_create;

private _ehDeleted = [_officer, "Deleted", {
    params [
        ["_officer", objNull, [objNull]]
    ];
    _thisArgs params ["_taskID"];

    _officer removeEventHandler [_thisType, _thisID];
    [_taskID, "FAILED"] call btc_task_fnc_setState;
}, [_taskID]] call CBA_fnc_addBISEventHandler;

private _group = [];
{
    private _grp = createGroup btc_enemy_side;
    private _unit = _grp createUnit [selectRandom btc_type_units, _x, [], 0, "CAN_COLLIDE"];
    [_unit] joinSilent _grp;
    _group pushBack _grp;
    _grp setVariable ["no_cache", true];
    _grp setVariable ["btc_city", _city];
} forEach (_buildingPos - [_pos]);

_trigger = createTrigger ["EmptyDetector", _pos, false];
_trigger setVariable ["group", _group];
_trigger setTriggerArea [20, 20, 0, false];
_trigger setTriggerActivation [str btc_player_side, "PRESENT", true];
_trigger setTriggerStatements ["this", "private _group = thisTrigger getVariable 'group'; {_x setCombatMode 'RED';} forEach _group;", "private _group = thisTrigger getVariable 'group'; {_x setCombatMode 'WHITE';} forEach _group;"];

private _toDelete = _group + [_group_officer, _trigger];

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    !alive _officer
};
if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {
    [[], _toDelete] call btc_fnc_delete;
};

[_kill_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
private _dogTag_taskID = _taskID + "dt";
[[_dogTag_taskID, _taskID], 27, _officer, _officerName] call btc_task_fnc_create;
private _officer_dogtagData = [_officer] call ace_dogtags_fnc_getDogtagData;
private _globalVariableName = format ["btc_%1", _dogTag_taskID];

["btc_side_killDogTagFound", {
    params ["_globalVariableName", "_dogTag"];
    _thisArgs params ["_officer_dogtagData", "_dogTag_taskID", "_taskID", "_thisArgs_globalVariableName", "_officer", "_ehDeleted"];

    if (_thisArgs_globalVariableName isEqualTo _globalVariableName) then {
        [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        _officer removeEventHandler ["Deleted", _ehDeleted];

        [_dogTag_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
        [[_taskID + "bs", _taskID], 28, btc_create_object_point, [_officer_dogtagData select 0, typeOf btc_create_object_point]] call btc_task_fnc_create;
        missionNamespace setVariable [_globalVariableName, _dogTag];
        [_dogTag, _taskID] remoteExecCall ["btc_eh_fnc_trackItem", [0, -2] select isDedicated, _officer];
     };
}, [_officer_dogtagData, _dogTag_taskID, _taskID, _globalVariableName, _officer, _ehDeleted]] call CBA_fnc_addEventHandlerArgs;

["ace_dogtags_addDogtagItem", {
    params ["_dogTag", "_dogTagData"];
    _thisArgs params ["_officer_dogTagData", "_dogTag_taskID", "_taskID", "_globalVariableName"];

    if (_dogTagData isEqualTo _officer_dogTagData) then {
        [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        ["btc_side_killDogTagFound", [_globalVariableName, _dogTag]] call CBA_fnc_serverEvent;
    };
    _this
}, [_officer_dogTagData, _dogTag_taskID, _taskID, _globalVariableName]] remoteExecCall ["CBA_fnc_addEventHandlerArgs", [0, -2] select isDedicated, _officer];

private _IDEH_HandleDisconnect = [missionNamespace, "HandleDisconnect", {
    params [
        ["_player", objNull, [objNull]]
    ];
    _thisArgs params ["_globalVariableName", "_taskID"];

    if ((missionNamespace getVariable [_globalVariableName, ""]) in items _player) then {
        removeMissionEventHandler [_thisType, _thisID];
        [_taskID, "FAILED"] call btc_task_fnc_setState;
    };
}, [_globalVariableName, _taskID]] call CBA_fnc_addBISEventHandler;

waitUntil {sleep 5; 
    true in (
        (
            allPlayers inAreaArray [getPosWorld btc_create_object_point, 100, 100]
        ) apply {(missionNamespace getVariable [_globalVariableName, ""]) in itemCargo vehicle _x}
    ) ||
    _taskID call BIS_fnc_taskCompleted
};

_group_officer setVariable ["no_cache", false];
{
    _x setVariable ["no_cache", false];
} forEach _group;

[[], _toDelete] call btc_fnc_delete;
removeMissionEventHandler ["HandleDisconnect", _IDEH_HandleDisconnect];
if ((_taskID call BIS_fnc_taskState) in ["CANCELED", "FAILED"]) exitWith {[_taskID, _taskID call BIS_fnc_taskState] call btc_task_fnc_setState};

40 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call btc_task_fnc_setState;
