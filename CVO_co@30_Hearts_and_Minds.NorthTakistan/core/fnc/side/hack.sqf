
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_hack

Description:
    https://forums.bistudio.com/forums/topic/186316-how-to-open-the-land_dataterminal_01_f-data-terminal-nexus-update/
    http://killzonekid.com/arma-scripting-tutorials-uav-r2t-and-pip/
    http://killzonekid.com/arma-scripting-tutorials-scripted-charges/

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_hack"] spawn btc_side_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

private _useful = values btc_city_all select {
    _x getVariable ["occupied", false] &&
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"])
};

if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};

private _city = selectRandom _useful;
private _pos = [getPos _city, 100] call btc_fnc_randomize_pos;
private _house = selectRandom (([_pos, 100] call btc_fnc_getHouses) select 0);
if (isNil "_house") exitWith {[] spawn btc_side_fnc_create;};
_pos = selectRandom (_house buildingPos -1);

[_taskID, 16, _city, _city getVariable "name"] call btc_task_fnc_create;

_city setVariable ["spawn_more",true];

//// Create terminal \\\\
private _terminalType = "Land_DataTerminal_01_F";
private _terminal = createVehicle [_terminalType, [_pos, ASLToATL _pos] select surfaceIsWater _pos, [], 0, "CAN_COLLIDE"];
_pos = [[_pos, 100] call btc_fnc_randomize_pos, 50, 500, 30, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
private _launchsite = createVehicle ["Land_PenBlack_F", _pos, [], 0, "FLY"];
private _terminal_taskID = _taskID + "ter";
[[_terminal_taskID, _taskID], 17, _terminal, _terminalType] call btc_task_fnc_create;

//// Add interaction on Terminal \\\\
_terminal setVariable ["btc_terminal_taskID", _terminal_taskID, true];
[_terminal] remoteExecCall ["btc_int_fnc_terminal", [0, -2] select isDedicated, _terminal];

waitUntil {sleep 5; (_terminal_taskID call BIS_fnc_taskCompleted)};
if (_terminal_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {
    [[], [_terminal]] call btc_fnc_delete;
};

private _defend_taskID = _taskID + "df";
[[_defend_taskID, _taskID], 22, _terminal, _terminalType, true] call btc_task_fnc_create;

private _groups = [];
private _closest = [_city, values btc_city_all select {!(_x getVariable ["active", false])}, false] call btc_fnc_find_closecity;
for "_i" from 1 to (2 + round random 1) do {
    _groups pushBack ([btc_mil_fnc_send, [_closest, getPos _terminal, 1, selectRandom btc_type_motorized]] call CBA_fnc_directCall);
};

{
    _x setBehaviour "CARELESS"
} forEach _groups;

[_terminal, _launchsite modelToWorld [0, 100, 10]] remoteExecCall ["btc_log_fnc_place_create_camera", [0, -2] select isDedicated];

waitUntil {sleep 5; 
    _defend_taskID call BIS_fnc_taskCompleted ||
    grpNull in _groups ||
    !(_city getVariable ["active", false])
};

if (_defend_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {
    [[], [_terminal]] call btc_fnc_delete;
};

if !(_city getVariable ["active", false]) exitWith {
    [_taskID, "FAILED"] call btc_task_fnc_setState;
    [[], [_terminal]] call btc_fnc_delete;
};

//// Launch the hacked missile \\\\
_pos params ["_x", "_y"];
private _altitude = 20;
while {_altitude < 500} do {
    _altitude = _altitude + 3;
    (createVehicle ["DemoCharge_Remote_Ammo_Scripted", [_x, _y, _altitude], [], 0, "CAN_COLLIDE"]) setDamage 1;
    sleep 0.1;
};
private _rocket = createVehicle ["ace_rearm_Missile_AGM_02_F", [_x, _y, _altitude], [], 0, "CAN_COLLIDE"];
private _fx = createVehicle ["test_EmptyObjectForSmoke", [_x, _y, _altitude], [], 0, "CAN_COLLIDE"];
_fx attachTo [_rocket, [0, 0, 0]];

[[], [_rocket, _terminal, _fx]] call btc_fnc_delete;

80 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call btc_task_fnc_setState;
