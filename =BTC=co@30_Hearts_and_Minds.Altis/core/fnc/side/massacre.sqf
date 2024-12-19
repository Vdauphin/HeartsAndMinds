
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_massacre

Description:
    Move all dead civilians in a grave next to a church, inspired by Bucha massacre (Ukraine).

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_massacre"] spawn btc_side_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose an occupied City \\\\
private _useful = values btc_city_all select {
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"])
};
if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
[_useful, true] call CBA_fnc_shuffle;
private _city = objNull;
private _church = objNull;
while {_useful isNotEqualTo []} do {
    _city = _useful deleteAt 0;
    _church = nearestTerrainObjects [_city, ["CHURCH", "CHAPEL"], 470];
    if (_church isNotEqualTo []) then {
        break;
    };
};
if (_useful isEqualTo [] and _church isEqualTo []) exitWith {
    [] spawn btc_side_fnc_create;
};

private _pos = getPos _city;
private _radius = _city getVariable ["cachingRadius", 0];
private _roads = _pos nearRoads _radius/2;
_roads = _roads select {isOnRoad _x};
if (_roads isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
private _road = selectRandom _roads;

private _churchSorted = _church apply {[_road distance _x, _x]};
_churchSorted sort true;
_church = _churchSorted select 0 select 1;
[_taskID, 42, _church, [_city getVariable "name", typeOf _church]] call btc_task_fnc_create;

private _group = createGroup civilian;
private _civilians = [];
private _composition = [];
private _tasksID = [];
private _objtTypes = btc_type_sports + ["Land_Suitcase_F"] + btc_type_sleepingbag_folded;
[_objtTypes, true] call CBA_fnc_shuffle;

for "_i" from 1 to (2 + round random 3) do {
    private _roadPos = [_road, 3] call btc_ied_fnc_randomRoadPos;
     _roadPos params ["_pos", "_dir"];
    _pos = _pos getPos [random 5, _dir];
    private _unit = _group createUnit [selectRandom btc_civ_type_units, _pos, [], 0, "CAN_COLLIDE"];
    if (selectRandom [true, false]) then {
        [position _unit, 0.05, 1.5] call BIS_fnc_flies;
    };
    _unit setDir random 360;
    _unit setVariable ["btc_dont_delete", true];
    _unit setDamage 1;
    _civilians pushBack _unit;

    private _obj = createVehicle [selectRandom (btc_type_bottles + ["Land_FMradio_F", "Land_MobilePhone_smart_F","Land_RiceBox_F", "Land_Orange_01_F"]), _pos, [], 2, "NONE"];
    _obj addTorque [4,0,0];
    _composition pushBack _obj;

    _roadPos params ["_pos", "_dir"];
    _pos = _pos getPos [random 2, _dir];
    private _obj = createVehicle [selectRandom btc_type_bloods, _pos, [], 0, "CAN_COLLIDE"];
    _obj setDir random 360;
    _obj setVectorUp surfaceNormal _pos;
    _composition pushBack _obj;

    private _roadPos = [_road, 3] call btc_ied_fnc_randomRoadPos;
    _roadPos params ["_pos", "_dir"];
    _pos = _pos getPos [random 10, _dir];
    private _obj = createVehicle [_objtTypes deleteAt 0, _pos, [], 0, "CAN_COLLIDE"];
    _obj setDir random 360;
    _obj addTorque [6,0,0];
    _composition pushBack _obj;

    private _civ_taskID = _taskID + "cv" + str _i;
    _tasksID pushBack _civ_taskID;
    [[_civ_taskID, _taskID], 43, _unit, [name _unit, typeOf _unit], false, false] call btc_task_fnc_create;
    _unit setVariable ["btc_rep_playerKiller", _civ_taskID];
    if (roadsConnectedTo _road isNotEqualTo []) then {
        _road = (roadsConnectedTo _road) select 0;
    };
};

["ace_placedInBodyBag", {
    params ["_patient", "_bodyBag", "_isGrave", "_medic"];
    if (
        !(_patient in _thisArgs)
    ) exitWith {};

    _thisArgs deleteAt (_thisArgs find _patient);
    private _taskID = _patient getVariable ["btc_rep_playerKiller", ""];
    if (_isGrave) then {
        [{
            params ["_restingPlace", "_taskID"];
            private _church = nearestTerrainObjects [_restingPlace, ["CHURCH", "CHAPEL"], 50];
            if (_church isEqualTo []) then {
                [_taskID, "FAILED"] call BIS_fnc_taskSetState;
            } else {
                [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
            };
        }, [_bodyBag, _taskID], 0.2] call CBA_fnc_waitAndExecute;
    } else {
        _thisArgs pushBack _bodyBag;
        [_taskID, _bodyBag] call BIS_fnc_taskSetDestination;
    };
}, _civilians] call CBA_fnc_addEventHandlerArgs;

waitUntil {sleep 5;
    _taskID call BIS_fnc_taskCompleted ||
    _civilians select {!isNull _x} isEqualTo []
};

[[], _civilians + [_group] + _composition] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

if ("FAILED" in (_tasksID apply {_x call BIS_fnc_taskState})) then {
    [_taskID, "FAILED"] call btc_task_fnc_setState;
} else {
    [_taskID, "SUCCEEDED"] call btc_task_fnc_setState;
}
