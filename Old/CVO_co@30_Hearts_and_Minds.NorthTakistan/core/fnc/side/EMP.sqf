
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_EMP

Description:
    Find and destroy EMP station.

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_EMP"] spawn btc_side_fnc_create;
    (end)

Author:
    Giallustio

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

[_taskID, 36, [objNull, _city] select (btc_p_spect), _city getVariable "name"] call btc_task_fnc_create;

_city setVariable ["spawn_more", true];

private _radius = _city getVariable ["cachingRadius", 0];
private _composition = [];
private _tasksID = [];

for "_i" from 0 to (1 + round random 2) do {
    private _pos = [getPos _city, _radius] call btc_fnc_randomize_pos;
    _pos = [_pos, 0, 300, 15, false] call btc_fnc_findsafepos;

    private _antenna = btc_type_satelliteAntenna + btc_type_antenna;
    private _boxType = selectRandom (btc_cache_type select 0);
    private _composition_station = if (random 1 < 0.4) then { // Big station
        [
            [selectRandom btc_type_cargoEMP,46,[0.27,-0.33,0]],
            [selectRandom _antenna,random 360,[1.1,-1.2,2.6]],
            [selectRandom _antenna,random 360,[1.1,2.38,0]],
            [selectRandom _antenna,random 360,[-2.65,-0.43,0]],
            [selectRandom _antenna,random 360,[-0.25,-3,0]],
            [_boxType,random 360,[2.68,-0.129,0]]
        ]
    } else { // Small station
        [
            [selectRandom _antenna,random 360,[-0.3,-0.9,0]],
            [selectRandom btc_type_solarPanel,random 360,[-1.5,1,0]],
            [selectRandom _antenna,random 360,[0.5,1.1,0]],
            [_boxType,random 360,[0.9,-0.5,0]]
        ]
    };

    private _station = [_pos, random 360, _composition_station] call btc_fnc_create_composition;
    _composition append _station;
    private _box = _station select ((_station apply {typeOf _x}) find _boxType);
    btc_spect_emp pushBack _box;
    publicVariable "btc_spect_emp";

    if (random 1 > 0.5) then {
        _composition pushBack (createMine [selectRandom btc_type_mines, _box getPos [2, random 360], [], 0]);
    } else {
        if (random 1 > 0.5) then {
            private _direction = random 360;
            private _statics = btc_type_gl + btc_type_mg;
            [_pos getPos [5, _direction], _statics, _direction, [], _city] call btc_mil_fnc_create_static;
        };
    };

    private _destroy_taskID = _taskID + "dt" + str _i;
    _tasksID pushBack _destroy_taskID;
    [[_destroy_taskID, _taskID], 37, [_box, objNull] select (btc_p_spect), _composition_station select 0 select 0, false, false] call btc_task_fnc_create;

    [_box, "HandleDamage", {
        params [
            ["_box", objNull, [objNull]],
            ["_part", "", [""]],
            ["_damage", 0, [0]],
            ["_injurer", objNull, [objNull]],
            ["_ammo", "", [""]]
        ];
        _thisArgs params [
            ["_destroy_taskID", "", [""]]
        ];

        private _explosive = getNumber(configFile >> "cfgAmmo" >> _ammo >> "explosive") > 0;
        if (
             _explosive &&
            {_damage > 0.6} &&
            {_destroy_taskID call BIS_fnc_taskState isNotEqualTo "CANCELED"}
        ) then {
            private _pos = getPos _box;
            [_destroy_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
            private _fx = "test_EmptyObjectForSmoke" createVehicle _pos;
            _fx setPos _pos;
            [CBA_fnc_deleteEntity, [_fx], 120] call CBA_fnc_waitAndExecute;
            btc_spect_emp deleteAt (btc_spect_emp find _box);
            publicVariable "btc_spect_emp";
        } else {
            0
        };
    }, [_destroy_taskID]] call CBA_fnc_addBISEventHandler;
};

waitUntil {sleep 5;
    _taskID call BIS_fnc_taskCompleted ||
    !(false in (_tasksID apply {_x call BIS_fnc_taskCompleted}))
};

[[], _composition] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

80 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call btc_task_fnc_setState;
