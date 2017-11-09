
private ["_useful","_veh","_vehpos","_city","_pos","_marker","_unit_type","_index","_unit","_group","_veh_type"];

//// Choose a Marine location \\\\
_useful = [];
{if ((_x getVariable ["type",""] == "NameMarine") || (_x getVariable ["hasbeach",false])) then {_useful pushBack _x;};} foreach btc_city_all;
if (count _useful == 0) exitWith {[] spawn btc_fnc_side_create;};
_city = selectRandom _useful;
_pos = getPos _city;

//// Choose a random position \\\\
_vehpos = [_pos, 0, 600, 20, 2, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
_vehpos = [_vehpos select 0 ,_vehpos select 1,0];

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[10,_pos,_city getVariable "name"] call btc_fnc_task_create;

btc_side_jip_data = [10,_vehpos,_city getVariable "name"];

//// Create marker \\\\
_marker = createmarker [format ["sm_2_%1",_vehpos],_vehpos];
_marker setmarkertype "hd_flag";
_marker setmarkertext (localize "STR_BTC_HAM_SIDE_CIVTREAT_MRK"); //Civil need help
_marker setMarkerSize [0.6, 0.6];

//// Create civ on _vehpos \\\\
_veh_type = selectRandom btc_civ_type_boats;
_veh = createVehicle [_veh_type, _vehpos, [], 0, "NONE"];
_veh setDir (random 360);
_veh setPos _vehpos;

_unit_type = selectRandom btc_civ_type_units;
_group = createGroup civilian;
_group setVariable ["no_cache",true];
_group setVariable ["btc_patrol",true];
_unit = _group createUnit [_unit_type, _pos, [], 0, "NONE"];
_index = 1 + floor (random (_veh emptyPositions "cargo"));
_unit assignAsCargoIndex [_veh, _index];
_unit moveinCargo [_veh, _index];
sleep 1;
waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || ({_x distance _unit < 5000} count playableUnits > 0))};
[_unit] call btc_fnc_set_damage;

{_x call btc_fnc_civ_unit_create} foreach units _group;

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || !Alive _unit || {_unit call ace_medical_fnc_isInStableCondition && [_unit] call ace_common_fnc_isAwake})};

btc_side_assigned = false;publicVariable "btc_side_assigned";
[[_marker], [_veh], [], [_group]] call btc_fnc_delete;

if (btc_side_aborted || btc_side_failed || !Alive _unit) exitWith {
	10 remoteExec ["btc_fnc_task_fail", 0];
};

10 call btc_fnc_rep_change;

10 remoteExec ["btc_fnc_task_set_done", 0];
