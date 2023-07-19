
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_supply

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_supply"] spawn btc_side_fnc_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

private _useful = values btc_city_all select {
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"])
};

if (_useful isEqualTo []) then {_useful = values btc_city_all;};

private _city = selectRandom _useful;
private _pos = [getPos _city, 100] call btc_fnc_randomize_pos;
_pos = [_pos, 0, _city getVariable ["cachingRadius", 100], 20, false] call btc_fnc_findsafepos;

[_taskID, 3, _city, _city getVariable "name"] call btc_task_fnc_create;
private _move_taskID = _taskID + "mv";
[[_move_taskID, _taskID], 18, _pos, btc_supplies_cargo] call btc_task_fnc_create;

private _area = createMarker [format ["sm_%1", _pos], _pos];
_area setMarkerShape "ELLIPSE";
_area setMarkerBrush "SolidBorder";
_area setMarkerSize [30, 30];
_area setMarkerAlpha 0.3;
_area setmarkercolor "colorBlue";

private _type_cone = selectRandom btc_type_cones;
private _fences = selectRandom btc_type_fences;
private _composition = [
    [_type_cone,random 360,[0.751953,-0.587891,0]],
    [selectRandom btc_type_foodSack, random 360,[-0.498047,-0.949219,0]],
    [_type_cone,random 360,[0.671875,0.769531,0]],
    [_type_cone,random 360,[-1.25586,-0.566406,0]],
    [selectRandom btc_type_garbage,0,[0.808594,1.31055,0]],
    [_type_cone,random 360,[-1.33594,0.791016,0]],
    [selectRandom btc_type_table,0,[-0.195313,-1.65039,0]],
    [_type_cone,random 360,[0.648438,2.17578,0]],
    [selectRandom btc_type_table,0,[1.82031,-1.66406,0]],
    [_type_cone,random 360,[-1.35938,2.19727,0]],
    [_type_cone,random 360,[2.57227,0.550781,0]],
    [selectRandom btc_type_table,0,[-2.19727,-1.64844,0]],
    [_type_cone,random 360,[2.65234,-0.806641,0]],
    ["Land_ShelvesWooden_F",0,[0.748047,-2.67383,0]],
    [selectRandom btc_type_seat,169,[0.0859375,-2.95898,0]],
    ["Land_ShelvesWooden_F",0,[-1.19922,-2.7168,0]],
    [_type_cone,random 360,[-3.09766,-0.724609,0]],
    [_type_cone,random 360,[2.54883,1.95703,0]],
    [_type_cone,random 360,[-3.17773,0.632813,0]],
    [selectRandom btc_type_seat,175,[2.02148,-2.80078,0]],
    [selectRandom btc_type_seat,198,[-2.48242,-2.75781,0]],
    [_type_cone,random 360,[-3.20117,2.03906,0]],
    [selectRandom btc_type_PaperBox,random 360,[0.732422,-3.97656,0]],
    [selectRandom btc_type_PaperBox,random 360,[-1.16016,-3.96289,0]],
    [selectRandom btc_type_EmergencyBlanket,random 360,[-3.34766,-3.17383,0]],
    [selectRandom btc_type_Sponsor,201,[-4.64453,2.35352,0]],
    [selectRandom btc_type_Scrapyard, random 360,[-5.15234,-4.17969,0]],
    [selectRandom btc_type_portable_light,150,[2.60156,-6.82031,0]],
    [_fences,24,[6.77148,-3.02344,0]],
    [_fences,321,[-6.625,-3.70313,0]],
    [selectRandom btc_type_power,117,[5.92578,-5.69336,0]],
    ["Flag_IDAP_F",0,[-3.80859,-6.70703,0]],
    [selectRandom btc_type_EmergencyBlanket,random 360,[-2.17969,-8.61328,0]],
    [selectRandom btc_type_foodSack, random 360,[2.6875,-9.44531,0]],
    [selectRandom btc_type_Sponsor,204,[9.34766,-5.02539,0]],
    [selectRandom btc_type_PlasticCase,353,[-2.60156,-11.7715,0]],
    [selectRandom btc_type_MedicalTent,0,[0.322266,-12.4043,0]],
    [selectRandom btc_type_PaperBox,random 360,[2.94531,-14.9102,0]],
    [selectRandom btc_type_seat,229,[-2.07422,-15.2441,0]],
    [selectRandom btc_type_cargo_ruins,300,[-10.0488,-12.1152,0]]
];
private _direction_composition = random 360;
private _composition_objects = [_pos, _direction_composition, _composition] call btc_fnc_create_composition;

btc_supplies_mat params ["_food", "_water"];
waitUntil {sleep 5; (_move_taskID call BIS_fnc_taskCompleted || (nearestObjects [_pos, [btc_supplies_cargo] + _food + _water, 30]) isNotEqualTo [])};

private _drop_taskID = _taskID + "dr";
if (_move_taskID call BIS_fnc_taskState isNotEqualTo "CANCELED") then {
    [_move_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [
        [_drop_taskID, _taskID], 19,
        (nearestObjects [_pos, [btc_supplies_cargo] + _food + _water, 30]) select 0,
        selectRandom(_food + _water), true
    ] call btc_task_fnc_create;
};

[getPos _city, _pos getPos [10, _direction_composition]] call btc_civ_fnc_evacuate;

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    count (nearestObjects [_pos, _food + _water, 30]) >= 2
};

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {
    [[_area], _composition_objects] call btc_fnc_delete;
};

50 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call btc_task_fnc_setState;

[[_area], _composition_objects + nearestObjects [_pos, _food + _water + [btc_supplies_cargo], 30]] call btc_fnc_delete;
