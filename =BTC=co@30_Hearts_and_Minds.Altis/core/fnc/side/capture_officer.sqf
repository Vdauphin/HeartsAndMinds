
/* ----------------------------------------------------------------------------
Function: btc_fnc_side_capture_officer

Description:
    Thanks DAP for inspiration.

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_fnc_side_capture_officer"] spawn btc_fnc_side_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose two Cities \\\\
private _usefuls = btc_city_all select {!(isNull _x) && !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine"]) && !(_x getVariable ["occupied", false])};
if (_usefuls isEqualTo []) then {_usefuls = + (btc_city_all select {!(isNull _x)});};
private _city2 = selectRandom _usefuls;

private _area = (getNumber (configFile >> "CfgWorlds" >> worldName >> "MapSize"))/4;
private _cities = btc_city_all select {!(isNull _x) && (_x distance _city2 > _area)};
_usefuls = _cities select {!((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine"]) && (_x getVariable ["occupied", false])};
if (_usefuls isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};
private _city1 = selectRandom _usefuls;

//// Find roads \\\\
private _radius_x = _city1 getVariable ["RadiusX",0];
private _roads = _city1 nearRoads (_radius_x * 2);
_roads = _roads select {(_x distance _city1 > _radius_x) && isOnRoad _x};
if (_roads isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};
private _road = selectRandom _roads;
private _pos1 = getPosATL _road;
private _pos2 = getPos _city2;

[_taskID, 14, _pos2, _city2 getVariable "name"] call btc_fnc_task_create;

//// Create markers \\\\
private _marker1 = createMarker [format ["sm_2_%1", getPos _city1], getPos _city1];
_marker1 setMarkerType "hd_flag";
[_marker1, "str_a3_campaign_b_m06_marker01"] remoteExecCall ["btc_fnc_set_markerTextLocal", [0, -2] select isDedicated, _marker1]; //Convoy Start
_marker1 setMarkerSize [0.6, 0.6];

private _marker2 = createMarker [format ["sm_2_%1", _pos2], _pos2];
_marker2 setMarkerType "hd_flag";
[_marker2, "STR_BTC_HAM_SIDE_CONVOY_MRKEND"] remoteExecCall ["btc_fnc_set_markerTextLocal", [0, -2] select isDedicated, _marker2]; //Convoy End
_marker2 setMarkerSize [0.6, 0.6];

private _area = createMarker [format ["sm_%1", _pos2], _pos2];
_area setMarkerShape "ELLIPSE";
_area setMarkerBrush "SolidBorder";
_area setMarkerSize [_radius_x/1.5, _radius_x/1.5];
_area setMarkerAlpha 0.3;
_area setmarkercolor "colorBlue";

private _markers = [_marker1, _marker2, _area];

//// Create convoy \\\\
private _group = createGroup btc_enemy_side;
_group setVariable ["no_cache", true];

private _vehs = [];
private _veh_types = btc_type_motorized select {!(_x isKindOf "air")};
for "_i" from 0 to (1 + round random 1) do {
    private _veh = [_group, _pos1, selectRandom _veh_types, [_road] call btc_fnc_road_direction] call btc_fnc_mil_createVehicle;

    _vehs pushBack _veh;

    _road = (roadsConnectedTo _road) select 0;
    _pos1 = getPosATL _road;
};

private _captive = selectRandom units _group;
removeAllWeapons _captive;
_group selectLeader _captive;

private _surrender_taskID = _taskID + "su";
[[_surrender_taskID, _taskID], 24, objNull, typeOf _captive] call btc_fnc_task_create;
private _handcuff_taskID = _taskID + "hc";
private _back_taskID = _taskID + "bk";

[_group, _pos2, -1, "MOVE", "SAFE", "RED", "LIMITED", "COLUMN", format ["['%1', 'FAILED'] call BIS_fnc_taskSetState;", _taskID], [0, 0, 0], _radius_x / 1.5] call CBA_fnc_addWaypoint;

//// Create trigger \\\\
private _trigger = createTrigger ["EmptyDetector", getPos _city1];
_trigger setVariable ["captive", _captive];
_trigger setTriggerArea [15, 15, 0, false];
_trigger setTriggerActivation [str btc_player_side, "PRESENT", true];
_trigger setTriggerStatements ["this", format ["_captive = thisTrigger getVariable 'captive'; deleteVehicle thisTrigger; doStop _captive; [_captive, true] call ace_captives_fnc_setSurrendered; ['%1', 'SUCCEEDED'] call BIS_fnc_taskSetState; [['%2', '%4'], 29, _captive] call btc_fnc_task_create; [['%3', '%4'], 21, btc_create_object_point, typeOf btc_create_object_point] call btc_fnc_task_create;", _surrender_taskID, _handcuff_taskID, _back_taskID, _taskID], ""];
_trigger attachTo [_captive, [0, 0, 0]];

private _agent = [leader _group, _pos2, _taskID] call btc_fnc_info_path;
_agent addEventHandler ["PathCalculated", {
    params ["_agent", "_path"];

    [12] remoteExecCall ["btc_fnc_show_hint", [0, -2] select isDedicated];
    _agent removeEventHandler ["PathCalculated", _thisEventHandler];
}];

["ace_captiveStatusChanged", {
    params ["_unit", "_state", "_type"];
    _thisArgs params ["_captive", "_handcuff_taskID"];

    if (_captive isEqualTo objNull) then {
        [_thisType, _thisId] call CBA_fnc_removeEventHandler;
    };
    if (_unit isEqualTo _captive && _type isEqualTo "SetHandcuffed") then {
        [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        [_handcuff_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
    };
    _this
}, [_captive, _handcuff_taskID]] call CBA_fnc_addEventHandlerArgs;

waitUntil {sleep 5; (!(alive _captive) || (_captive inArea [getPosWorld btc_create_object_point, 100, 100, 0, false]) || _taskID call BIS_fnc_taskCompleted)};

_markers append (allMapMarkers select {(_x select [0, count _taskID]) isEqualTo _taskID});

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {
    deleteVehicle _trigger;
    [_markers, _vehs + [_group]] call btc_fnc_delete;
};

if (!alive _captive || _taskID call BIS_fnc_taskState isEqualTo "FAILED") exitWith {
    deleteVehicle _trigger;
    [_taskID, "FAILED"] call btc_fnc_task_setState;
    _group setVariable ["no_cache", false];
    {
        _group = createGroup btc_enemy_side;
        (crew _x) joinSilent _group;
        _group call btc_fnc_data_add_group;
    } forEach _vehs;
    [_markers, []] call btc_fnc_delete;
};

50 call btc_fnc_rep_change;

[_taskID, "SUCCEEDED"] call btc_fnc_task_setState;

[_markers, _vehs + [_captive, _group]] call btc_fnc_delete;
