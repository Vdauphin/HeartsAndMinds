
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_rescue

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_rescue"] spawn btc_side_fnc_create;
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
private _pos = [getPos _city, (_city getVariable ["cachingRadius", 0])/2 - 100] call btc_fnc_randomize_pos;
_pos = [_pos, 0, 50, 13, 0, 60 * (pi / 180), 0] call btc_fnc_findsafepos;

_city setVariable ["spawn_more", true];

waitUntil {!isNil "btc_vehicles"}; // Wait for loading vehicles from db

private _heli_type = typeOf selectRandom ((btc_vehicles + btc_veh_respawnable) select {
    _x isKindOf "air" &&
    {!(unitIsUAV _x)}
});
private _heli = createVehicle [_heli_type, _pos, [], 0, "NONE"];
_heli setVariable ["btc_dont_delete", true];
_heli setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
_heli setDamage 1;
_heli enableSimulation false;
_heli setPos [getPosASL _heli select 0, getPosASL _heli select 1, 0 - 1.5];
private _pitch = if (random 1 > 0.5) then {
    random 40
} else {
    -1 * random 40
};
private _bank = if (random 1 > 0.5) then {
    random 40
} else {
    -1 * random 40
};
[_heli, _pitch, _bank] call BIS_fnc_setPitchBank;
private _fx = createVehicle ["test_EmptyObjectForSmoke", _pos, [], 0, "CAN_COLLIDE"];

private _group = createGroup btc_player_side;
_group setVariable ["no_cache", true];
private _crew = getText (configfile >> "CfgVehicles" >> _heli_type >> "crew");
_crew createUnit [_pos, _group];

[_taskID, 13, _city, _city getVariable "name"] call btc_task_fnc_create;
private _find_taskID = _taskID + "mv";
[[_find_taskID, _taskID], 20, objNull, _crew] call btc_task_fnc_create;
private _back_taskID = _taskID + "bk";

private _units = [];
private _triggers = [];
{
    _x setCaptive true;
    removeAllWeapons _x;
    _x setBehaviour "CARELESS";
    _x setDir (random 360);
    _x setUnitPos "DOWN";
    _units pushBack _x;
    //// Create trigger \\\\
    private _trigger = createTrigger ["EmptyDetector", getPos _city, false];
    _trigger setVariable ["unit", _x];
    _trigger setTriggerArea [20, 20, 0, false, 10];
    _trigger setTriggerActivation [str btc_player_side, "PRESENT", false];
    _trigger setTriggerStatements ["this", format ["_unit = thisTrigger getVariable 'unit'; [_unit] join (thisList select 0); _unit setUnitPos 'UP'; ['%1', 'SUCCEEDED'] call BIS_fnc_taskSetState; [['%2', '%3'], 21, btc_create_object_point, typeOf btc_create_object_point, true] call btc_task_fnc_create;", _find_taskID, _back_taskID, _taskID], ""];
    _trigger attachTo [_x, [0, 0, 0]];
    _triggers pushBack _trigger;
} forEach units _group;

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    _units select {_x distance btc_create_object_point > 100} isEqualTo [] ||
    _units select {alive _x} isEqualTo []
};

private _rep = 50;
if (_units select {alive _x} isEqualTo []) then {
    [_back_taskID, "FAILED"] call BIS_fnc_taskSetState;
    private _bodyBag_taskID = _taskID + "bb";
    {
        private _IDDeleted = [_x, "Deleted", {
            params [
                ["_unit", objNull, [objNull]]
            ];
            _thisArgs params ["_taskID"];

            if (_unit inArea [[-5000, -5000, 0], 10, 10, 0, false]) exitWith {}; // Detect if the body is inside a bodybag (https://github.com/acemod/ACE3/blob/44050df98b00e579e5b5a79c0d76d4d1138b4baa/addons/medical_treatment/functions/fnc_placeInBodyBag.sqf#L40)
            [_taskID, "FAILED"] call btc_task_fnc_setState;
        }, [_taskID]] call CBA_fnc_addBISEventHandler;

        private _unitBodyBag_taskID = _bodyBag_taskID + str(_forEachIndex);
        [[_unitBodyBag_taskID, _taskID], 34, _x, [([_x] call ace_dogtags_fnc_getDogtagData) select 0, typeOf _x]] call btc_task_fnc_create;
        ["ace_placedInBodyBag", {
            params ["_patient", "_bodyBag"];
            _thisArgs params ["_unit", "_unitBodyBag_taskID", "_taskID", "_IDDeleted"];

            if (_patient isEqualTo _unit) then {
                _patient removeEventHandler ["Deleted", _IDDeleted];

                [_thisType, _thisId] call CBA_fnc_removeEventHandler;
                [_unitBodyBag_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

                private _base_taskID = _taskID + "bs";
                [[_base_taskID, _taskID], 35, btc_create_object_point, [([_patient] call ace_dogtags_fnc_getDogtagData) select 0, typeOf btc_create_object_point]] call btc_task_fnc_create;

                [_bodyBag, "Deleted", {
                    params [
                        ["_bodyBag", objNull, [objNull]]
                    ];
                    _thisArgs params ["_taskID"];

                    if (_taskID call BIS_fnc_taskCompleted) exitWith {};
                    [_taskID, "FAILED"] call btc_task_fnc_setState;
                }, [_taskID]] call CBA_fnc_addBISEventHandler;
            };
            _this
        }, [_x, _unitBodyBag_taskID, _taskID, _IDDeleted]] call CBA_fnc_addEventHandlerArgs;
    } forEach _units;

    private _dogTagList = _units apply {([_x] call ace_dogtags_fnc_getDogtagData) select 0};

    waitUntil {sleep 5; 
        _taskID call BIS_fnc_taskCompleted ||
        {
            (([_x] call ace_dogtags_fnc_getDogtagData) select 0) in _dogTagList
        } count (nearestObjects [btc_create_object_point, ["ACE_bodyBagObject"], 100]) >= count _units
    };
    _rep = 40;
};

{
    deleteVehicle _x;
} forEach _triggers;
[[], [_heli, _fx, _group] + _units] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState in ["CANCELED", "FAILED"]) exitWith {};

_rep call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call btc_task_fnc_setState;
