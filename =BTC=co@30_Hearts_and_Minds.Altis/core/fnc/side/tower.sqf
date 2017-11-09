
private ["_useful","_city","_pos","_road","_roads","_marker","_statics","_tower_type","_tower","_direction","_area","_power_type","_cord_type","_btc_composition","_btc_composition_tower"];

_useful = btc_city_all select {(_x getVariable ["occupied",false] && {_x getVariable ["type",""] != "NameLocal"} && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine"))};

if (_useful isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};

_city = selectRandom _useful;

_pos = [getPos _city, 100] call btc_fnc_randomize_pos;

_roads = _pos nearRoads 100;
_roads = _roads select {isOnRoad _x};
if (_roads isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};
_road = selectRandom _roads;
_pos = getPos _road;
_direction = [_road] call btc_fnc_road_direction;

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[7,_pos,_city getVariable "name"] call btc_fnc_task_create;

btc_side_jip_data = [7,_pos,_city getVariable "name"];

_city setVariable ["spawn_more",true];

_area = createmarker [format ["sm_%1",_pos],_pos];
_area setMarkerShape "ELLIPSE";
_area setMarkerBrush "SolidBorder";
_area setMarkerSize [30, 30];
_area setMarkerAlpha 0.3;
_area setmarkercolor "colorBlue";

_marker = createmarker [format ["sm_2_%1",_pos],_pos];
_marker setmarkertype "hd_flag";
_marker setmarkertext (localize "STR_BTC_HAM_SIDE_TOWER_MRK"); //Radio Tower
_marker setMarkerSize [0.6, 0.6];

//// Randomise composition \\\\
_tower_type = selectRandom btc_type_tower;
_power_type = selectRandom btc_type_power;
_cord_type = selectRandom btc_type_cord;
_btc_composition_tower = [
	[_tower_type,0,[0,0,0]],
	[_cord_type,63,[-1.30664,0.939453,0]],
	[_power_type,24,[-4.56885,-0.231445,0]]
];

//// Create tower with static at _pos \\\\
_statics = btc_type_gl + btc_type_mg;
[[(_pos select 0) + (sin(_direction)*5), (_pos select 1) + (cos(_direction)*5), (_pos select 2)],_statics,_direction] call btc_fnc_mil_create_static;
[[(_pos select 0) - (sin(_direction)*5), (_pos select 1) - (cos(_direction)*5), (_pos select 2)],_statics,_direction + 180] call btc_fnc_mil_create_static;

_btc_composition = [_pos,_direction,_btc_composition_tower] call btc_fnc_create_composition;
_tower = _btc_composition select ((_btc_composition apply {typeOf _x}) find _tower_type);

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || !Alive _tower )};

btc_side_assigned = false;publicVariable "btc_side_assigned";
[[_area,_marker], _btc_composition, [], []] call btc_fnc_delete;

if (btc_side_aborted || btc_side_failed ) exitWith {
	7 remoteExec ["btc_fnc_task_fail", 0];
};

80 call btc_fnc_rep_change;

7 remoteExec ["btc_fnc_task_set_done", 0];
