
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_checkpoint

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_checkpoint"] spawn btc_side_fnc_create;
    (end)

Author:
    Giallustio

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
private _pos = getPos _city;

[_taskID, 9, objNull, _city getVariable "name"] call btc_task_fnc_create;

_city setVariable ["spawn_more", true];

private _statics = btc_type_gl + btc_type_mg;
private _radius = _city getVariable ["cachingRadius", 0];

private _boxes = [];
private _composition = [];
private _blacklist = [];
for "_i" from 1 to (2 + round random 2) do {
    //// Choose a road \\\\
    private _pos = [getPos _city, _radius/4] call btc_fnc_randomize_pos;
    private _roads = _pos nearRoads 200;
    _roads = (_roads select {isOnRoad _x}) - _blacklist;
    if (_roads isEqualTo []) then {continue};
    private _road = selectRandom _roads;
    _blacklist pushBack _road;
    _pos = getPos _road;

    private _direction = [_road] call btc_fnc_road_direction;

    //// Randomise composition \\\\
    private _type_barrel = selectRandom btc_type_barrel;
    private _type_barrel_canister1 = selectRandom (btc_type_barrel + btc_type_canister);
    private _type_barrel_canister2 = selectRandom (btc_type_barrel + btc_type_canister);
    private _type_pallet = selectRandom btc_type_pallet;
    private _type_box = selectRandom btc_type_box;
    private _type_cone = selectRandom btc_type_cones;
    private _type_barrier = selectRandom btc_type_barrier;
    private _composition_checkpoint = [
        [_type_barrel,10,[0.243652,-2.78906,0]],
        [_type_barrel,20,[-0.131836,3.12939,0]],
        ["Land_BagFence_Long_F",90,[0.769531,-4.021,0]],
        ["Land_BagFence_Long_F",90,[-0.638672,4.31787,0]],
        ["Flag_Red_F",-90,[2.23193,-4.375,0]],
        [_type_barrel_canister1,0,[1.27393,-4.93604,0]],
        [_type_pallet,-70,[-5,3.75342,0]],
        [_type_barrel_canister2,0,[1.83984,-4.95264,0]],
        [_type_box,180,[-1.97998,4.88574,0]],
        [_type_barrier,180,[2.26367,-5.38623,0]],
        [_type_cone,180,[1.14771,-5.89697,0.00211954]],
        [_type_barrier,0,[-2.1416,5.66553,0]],
        [_type_cone,0,[-1.03101,6.18164,0.00211954]],
        [_type_cone,180,[2.81616,-5.81689,0.00211954]],
        [_type_cone,0,[-2.6731,6.17773,0.00211954]]
    ];

    //// Create checkpoint with static at _pos \\\\
    _pos params ["_x", "_y", "_z"];
    private _posStatic = [_x -2.39185*cos(-_direction) - 2.33984*sin(-_direction), _y  + 2.33984 *cos(-_direction) -2.39185*sin(-_direction), _z];
    [_posStatic, _statics, _direction + 180, [], _city] call btc_mil_fnc_create_static;

    private _posStatic = [_x + 2.72949*cos(-_direction) - -2.03857*sin(-_direction), _y -2.03857*cos(-_direction) +2.72949*sin(-_direction), _z];
    [_posStatic, _statics, _direction, [], _city] call btc_mil_fnc_create_static;

    _composition append ([_pos, _direction, _composition_checkpoint] call btc_fnc_create_composition);

    private _boxe = nearestObject [_pos, _type_box];
    _boxe setVariable ["ace_cookoff_enable", false, true];
    _boxe setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
    private _destroy_taskID = _taskID + "dt" + str _i;
    [[_destroy_taskID, _taskID], 23, _boxe, _type_box, false, false] call btc_task_fnc_create;
    [_boxe, _destroy_taskID] spawn {
        params ["_boxe", "_destroy_taskID"];

        private _pos = getPos _boxe;
        waitUntil {sleep 5; _destroy_taskID call BIS_fnc_taskCompleted || !(alive _boxe)};
        if (_destroy_taskID call BIS_fnc_taskState isNotEqualTo "CANCELED") then {
            [_destroy_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
            private _fx = "test_EmptyObjectForSmoke" createVehicle _pos;
            _fx setPos _pos;
            sleep 120;
            _fx call CBA_fnc_deleteEntity;
        };
    };
    _boxes pushBack _boxe;
};

if (_boxes isEqualTo []) then {[_taskID, "CANCELED"] call btc_task_fnc_setState;};

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    _boxes select {alive _x} isEqualTo []
};

[[], _boxes + _composition] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

80 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call btc_task_fnc_setState;
