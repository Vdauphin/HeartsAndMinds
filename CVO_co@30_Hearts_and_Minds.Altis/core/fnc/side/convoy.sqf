
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_convoy

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_convoy"] spawn btc_side_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose two Cities \\\\
private _usefuls = values btc_city_all select {
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"]) &&
    !(_x getVariable ["occupied", false])
};
if (_usefuls isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
private _city2 = selectRandom _usefuls;

private _area = (getNumber (configFile >> "CfgWorlds" >> worldName >> "MapSize"))/4;
private _cities = values btc_city_all select {_x distance _city2 > _area};
_usefuls = _cities select {
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"]) &&
    _x getVariable ["occupied", false]
};
if (_usefuls isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
private _city1 = selectRandom _usefuls;

//// Find Road \\\\
private _radius = (_city1 getVariable ["cachingRadius", 0])/2;
private _roads = _city1 nearRoads (_radius * 2);
_roads = _roads select {(_x distance _city1 > _radius) && isOnRoad _x};
if (_roads isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
private _road = selectRandom _roads;
private _pos1 = getPosATL _road;
private _pos2 = getPos _city2;

[_taskID, 12, _pos1, _city1 getVariable "name"] call btc_task_fnc_create;

//// Create markers \\\\
private _marker1 = createMarker [format ["sm_2_%1", _pos1], _pos1];
_marker1 setMarkerType "hd_flag";
[_marker1, "str_a3_campaign_b_m06_marker01"] remoteExecCall ["btc_fnc_set_markerTextLocal", [0, -2] select isDedicated, _marker1]; //Convoy start
_marker1 setMarkerSize [0.6, 0.6];

private _marker2 = createMarker [format ["sm_2_%1", _pos2], _pos2];
_marker2 setMarkerType "hd_flag";
[_marker2, "STR_BTC_HAM_SIDE_CONVOY_MRKEND"] remoteExecCall ["btc_fnc_set_markerTextLocal", [0, -2] select isDedicated, _marker2]; //Convoy end
_marker2 setMarkerSize [0.6, 0.6];

private _area = createMarker [format ["sm_%1", _pos2], _pos2];
_area setMarkerShape "ELLIPSE";
_area setMarkerBrush "SolidBorder";
_area setMarkerSize [_radius/2, _radius/2];
_area setMarkerAlpha 0.3;
_area setmarkercolor "colorBlue";

private _markers = [_marker1, _marker2, _area];

/// Show info path\\\
private _veh_types = btc_type_motorized select {!(_x isKindOf "air")};
private _agent = [btc_info_fnc_path, [_pos1, _pos2, _taskID, _veh_types select 0]] call CBA_fnc_directCall;
private _startingPath = time;

waitUntil {
    !isNil {_agent getVariable "btc_path"} ||
    {time > _startingPath + 10}
};

private _path = _agent getVariable ["btc_path", []];
if (count _path <= 35) exitWith {
    _markers append (allMapMarkers select {(_x select [0, count _taskID]) isEqualTo _taskID});
    [_markers, [_agent]]  call btc_fnc_delete;
    [_taskID, "CANCELED"] call BIS_fnc_taskSetState;
};

//// Create convoy \\\\
private _group = createGroup btc_enemy_side;
_group setVariable ["no_cache", true];
_group setVariable ["acex_headless_blacklist", true];
[_group] call CBA_fnc_clearWaypoints;
private _convoyLength = 3 + round random 2;
private _listPositions = _path select [40, _convoyLength + 1];
reverse _listPositions;
[_group, ASLToAGL (_listPositions select 0), -1, "SENTRY", "SAFE", "RED", "LIMITED", "COLUMN"] call CBA_fnc_addWaypoint; // Make sure they don't move during spawn
private _delay = 0;
for "_i" from 1 to _convoyLength do {
    private _pos = _listPositions deleteAt 0;
    _delay = _delay + ([_group, ASLToAGL _pos, selectRandom _veh_types, (_listPositions select 0) getDir _pos] call btc_mil_fnc_createVehicle);
};

[{
    params ["_group"];

    _group call CBA_fnc_clearWaypoints;
    _this call CBA_fnc_addWaypoint;
    [12] remoteExecCall ["btc_fnc_show_hint", [0, -2] select isDedicated];

    private _vehs = (units _group) apply {assignedVehicle _x};
    {
        _x addCuratorEditableObjects [_vehs arrayIntersect _vehs, false];
    } forEach allCurators;
}, [
    _group, _pos2, -1, "MOVE", "SAFE", "RED", "LIMITED", "COLUMN",
    format ["['%1', 'FAILED'] call BIS_fnc_taskSetState;", _taskID], [0, 0, 0], _radius/2
], _delay] call btc_delay_fnc_waitAndExecute;

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    ((units _group) apply {assignedVehicle _x}) select {canMove _x} isEqualTo [] ||
    isNull _group
};

_markers append (allMapMarkers select {(_x select [0, count _taskID]) isEqualTo _taskID});

private _vehs = (units _group) apply {assignedVehicle _x};
_vehs = (_vehs arrayIntersect _vehs);
if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {
    [_markers, _vehs + [_group]] call btc_fnc_delete;
};

if (_taskID call BIS_fnc_taskState isEqualTo "FAILED") exitWith {
    _group setVariable ["no_cache", false];
    {
        private _group = createGroup btc_enemy_side;
        (crew _x) joinSilent _group;
        [btc_data_fnc_add_group, _group] call CBA_fnc_directCall;
    } forEach _vehs;
    [_markers] call btc_fnc_delete;
};

[_markers, _vehs + [_group]]  call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

50 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
