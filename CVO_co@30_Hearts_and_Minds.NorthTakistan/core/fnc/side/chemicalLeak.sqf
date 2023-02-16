
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_chemicalLeak

Description:
    Some containers has been broken and drop some contaminated objects. Clean up those contaminated objects under a big shower.

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_chemicalLeak"] spawn btc_side_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

private _useful = values btc_city_all select {
    !(_x getVariable ["occupied", false]) &&
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"])
};
if (_useful isEqualTo []) then {_useful = values btc_city_all;};

private _city = selectRandom _useful;
private _pos = [getPos _city, 0, _city getVariable ["cachingRadius", 100], 30, false] call btc_fnc_findsafepos;

[_taskID, 30, _city, _city getVariable "name"] call btc_task_fnc_create;

private _distance_between_fences = 3;
private _number_of_fences = 2 * (3 + floor random 2);
private _area_size = _distance_between_fences * _number_of_fences;
private _offset = _area_size + _distance_between_fences/2;

//// Randomise composition \\\\
private _cone = selectRandom btc_type_cones;
private _barrier = selectRandom btc_type_barrier;
private _lamp = selectRandom btc_type_tentLamp;
private _connectorTent = selectRandom btc_type_connectorTent;
private _cfgVehicles = configfile >> "CfgVehicles";
private _editorCategory = getText(_cfgVehicles >> _connectorTent >> "editorCategory");
private _editorSubcategory = getText(_cfgVehicles >> _connectorTent >> "editorSubcategory");
private _connectorTentClosed = selectRandom (btc_type_connectorTentClosed select {
    _editorSubcategory isEqualTo (getText(_cfgVehicles >> _x >> "editorSubcategory")) &&
    _editorCategory isEqualTo (getText(_cfgVehicles >> _x >> "editorCategory"))
});
private _crossTent = selectRandom (btc_type_crossTent select {
    _editorSubcategory isEqualTo (getText(_cfgVehicles >> _x >> "editorSubcategory")) &&
    _editorCategory isEqualTo (getText(_cfgVehicles >> _x >> "editorCategory"))
});

private _doorCenter = 0;
private _composition_pattern = [];
for "_i" from -_number_of_fences to _number_of_fences do {
    _composition_pattern append [
        [_barrier, 0, [_i * _distance_between_fences, -_offset, 0]],
        [_barrier, 0, [_i * _distance_between_fences, _offset, 0]],
        [_barrier, 90, [ -_offset, _i * _distance_between_fences, 0]]
    ];
    if (_i isNotEqualTo 4) then {
        _composition_pattern pushBack [_barrier, 90, [_offset, _i * _distance_between_fences, 0]];
        if (random 1 > 0.7) then {
            _composition_pattern append [
                [selectRandom btc_type_portableLamp, 180, [_i * _distance_between_fences, -_offset + 1, 0]],
                [selectRandom btc_type_portableLamp, 0, [_i * _distance_between_fences, _offset - 1, 0]],
                [selectRandom btc_type_portableLamp, 270, [ -_offset + 1, _i * _distance_between_fences, 0]]
            ];
        };
    } else {
        _doorCenter = _i * _distance_between_fences;
    };
};

private _offset_door = - 60 + _offset;
private _sas = -12 + _offset;
_composition_pattern append [
    [_cone, random 360,[60.3545 + _offset_door,_doorCenter + 2,0]],
    [_cone, random 360,[60.3755 + _offset_door,_doorCenter - 2,0]],
    [selectRandom btc_type_portable_light,40,[61.1982 + _offset_door,_doorCenter - 4,0]],
    [selectRandom btc_type_portable_light,37,[60.7373 + _offset_door,_doorCenter + 5,0]],
    [selectRandom btc_type_body_bags,332,[63 + _offset_door,_doorCenter - 4.7,0.1]],
    [selectRandom btc_type_medicals,0,[65.4448 + _offset_door,_doorCenter - 3,0]],
    [selectRandom btc_type_first_aid_kits,0,[65.6187 + _offset_door,_doorCenter - 4.1,0]],
    [selectRandom btc_type_power,random [180, 223, 260],[63.9292 + _offset_door,_doorCenter + 7,0]],
    [selectRandom (btc_type_barrel + btc_type_canister), random 360,[66.4707 + _offset_door, _doorCenter - 4.3,0]],
    ["DeconShower_01_F",360,[_sas + 0.2,_doorCenter,0]],
    [selectRandom btc_type_tarp,0,[_sas + 0.2,_doorCenter,0]],
    [_connectorTent,270,[_sas + 3.87891,_doorCenter,0]],
    ["Land_MetalCase_01_large_F",272,[_sas + 4,_doorCenter-0.6,0]],
    [_crossTent,270,[_sas + 7.44434,_doorCenter,0]],
    ["Land_MetalCase_01_large_F",3,[_sas + 6.81201,_doorCenter + 2.97849,0]],
    [_connectorTentClosed,0,[_sas + 7.42627,_doorCenter + 3.46782,0]],
    [_connectorTentClosed,180,[_sas + 7.40625,_doorCenter - 3.64248,0]],
    ["Land_MetalCase_01_medium_F",177.972,[_sas + 8.23242,_doorCenter-2.8,0]],
    [_lamp,31.364,[_sas + 8.2876,_doorCenter + 4.12472,0]],
    [_lamp,150.453,[_sas + 8.45654,_doorCenter-4.58128,0]],
    [selectRandom(btc_type_sponge + btc_type_brush),random 360,[_sas + 9.89697,_doorCenter + 1,0]],
    ["DeconShower_01_F",0,[_sas + 10.9,_doorCenter,0]],
    [selectRandom btc_type_broom,random [98,108.489, 118],[_sas + 10.481,_doorCenter-1.46616,0]],
    [selectRandom(btc_type_sponge + btc_type_brush), random 360,[_sas + 10.5405,_doorCenter + 1.2,0]],
    ["TrashBagHolder_01_F",random [0, 0, 30],[_sas,_doorCenter - 2,0]],
    [selectRandom btc_type_tarp,0,[_sas + 10.9,_doorCenter,0]],
    [selectRandom btc_type_spill,random 360,[-1.96582,1.60091 - _doorCenter/2,0]],
    [selectRandom btc_type_spill,random 360,[4,3.95 - _doorCenter/2,0]],
    [selectRandom btc_type_spill,random 360,[3.47607,-4.70143 - _doorCenter/2,0]],
    [selectRandom btc_type_cargo_ruins,random 360,[6.31689,0.373489 - _doorCenter/2,0]],
    [selectRandom btc_type_cargo_ruins,random 360,[-4,7.95 - _doorCenter/2,0]],
    [selectRandom btc_type_spill,random 360,[0,11.95 - _doorCenter/2,0]],
    [selectRandom btc_type_SCBA,random 360,[_sas + 0.510742,_doorCenter + 1.4,0]]
];
{
    if (random 1 > 0.5) then {
        _composition_pattern pushBack _x;
    };
} forEach [
    [selectRandom btc_type_spill,random 360,[-4,-4.05 - _doorCenter/2,0]],
    [selectRandom btc_type_cargo_ruins,random 360,[-5.12109,-6.19316 - _doorCenter/2,0]],
    ["TrashBagHolder_01_F",random [0, 0, 30],[_sas,_doorCenter + 2.37756,0]]
];
{
    if (random 1 > 0.4) then {
        _composition_pattern pushBack ["HazmatBag_01_roll_F", random 360, _x];
    };
} forEach [
    [_sas + 4.39111,_doorCenter + 1.08578,0],
    [_sas + 3.87402,_doorCenter + 0.984695,0],
    [_sas + 4.22461,_doorCenter + 0.898758,0],
    [_sas + 8.41162,_doorCenter-0.9,0],
    [_sas + 8.60547,_doorCenter-1.1,0],
    [_sas + 8.74072,_doorCenter-0.75,0]
];

private _composition_objects = [_pos, random 360, _composition_pattern] call btc_fnc_create_composition;

private _chemical = [];
for "_i" from 1 to (5 + round random 5) do {
    private _m_pos = [_pos, _area_size - 14] call btc_fnc_randomize_pos;
    private _hazmat = createVehicle [selectRandom btc_type_hazmat, _m_pos, [], 2, "NONE"];
    _hazmat setDir random 360;
    _hazmat setVectorUp [random 1, random 1, random [-1, 0, 1]];
    [_hazmat] call btc_log_fnc_init;
    _chemical pushBack _hazmat;
    if (_i < 3 || random 1 > 0.5) then {
        btc_chem_contaminated pushBack _hazmat;
        publicVariable "btc_chem_contaminated";
    };
    btc_log_obj_created deleteAt (btc_log_obj_created find _hazmat);
};

private _bring_taskID = _taskID + "br";
[[_bring_taskID, _taskID], 31, _pos, btc_containers_mat select 0] call btc_task_fnc_create;

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    (nearestObjects [_pos, btc_containers_mat, 200]) isNotEqualTo []
};

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {
    [[], _composition_objects + _chemical] call btc_fnc_delete;
};

[_bring_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

[getPos _city, _pos getPos [_area_size * 2.5, _pos getDir _city]] call btc_civ_fnc_evacuate;

private _locate_taskID = _taskID + "lc";
[[_locate_taskID, _taskID], 32, _pos, typeOf((_chemical arrayIntersect btc_chem_contaminated) select 0)] call btc_task_fnc_create;
private _clean_taskID = _taskID + "cl";
private _bigShower = selectRandom (btc_chem_decontaminate select {_x isKindOf "DeconShower_02_F"});
[[_clean_taskID, _taskID], 33, _bigShower, typeOf _bigShower] call btc_task_fnc_create;

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    (_chemical arrayIntersect btc_chem_contaminated) select {!isNull _x} isEqualTo []
};

[[], _composition_objects + _chemical] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

50 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
