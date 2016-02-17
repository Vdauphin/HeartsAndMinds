
private ["_useful","_city","_pos","_road","_roads","_marker","_statics","_tower_type","_tower","_direction"];

_useful = [];
{if (_x getVariable ["occupied",false] && {_x getVariable ["type",""] != "NameLocal"} && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine")) then {_useful = _useful + [_x];};} foreach btc_city_all;

if (count _useful == 0) exitWith {[] spawn btc_fnc_side_create;};

_city = _useful select (floor random count _useful);

_pos = [getPos _city, 100] call btc_fnc_randomize_pos;

_roads = _pos nearRoads 100;

if (count _roads > 0) then {_road = (_roads select (floor random count _roads));
	_pos = getPos _road;
	};

_direction = [_road] call btc_fnc_road_direction;

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[[7,_pos,_city getVariable "name"],"btc_fnc_task_create",true] spawn BIS_fnc_MP;

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
_marker setmarkertext "Radio Tower";
_marker setMarkerSize [0.6, 0.6];

_tower_type = btc_type_tower select (floor (random (count btc_type_tower)));

_tower = createVehicle [_tower_type, _pos, [], 0, "NONE"];
_tower setDir (_direction);
_tower setPos (_pos);

_statics = btc_type_gl + btc_type_mg;
[[(_pos select 0) + (sin(_direction)*5), (_pos select 1) + (cos(_direction)*5), (_pos select 2)],_statics,_direction] call btc_fnc_mil_create_static;
[[(_pos select 0) - (sin(_direction)*5), (_pos select 1) - (cos(_direction)*5), (_pos select 2)],_statics,_direction + 180] call btc_fnc_mil_create_static;

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || !Alive _tower )};

{deletemarker _x} foreach [_area,_marker];

if (btc_side_aborted || btc_side_failed ) exitWith {
	[7,"btc_fnc_task_fail",true] spawn BIS_fnc_MP;
	btc_side_assigned = false;publicVariable "btc_side_assigned";
	_tower spawn {

		waitUntil {sleep 5; ({_x distance _this < 300} count playableUnits == 0)};

		deleteVehicle _this;
	};
};

80 call btc_fnc_rep_change;

[7,"btc_fnc_task_set_done",true] spawn BIS_fnc_MP;

_tower spawn {

	waitUntil {sleep 5; ({_x distance _this < 300} count playableUnits == 0)};

	deleteVehicle _this;
};


btc_side_assigned = false;publicVariable "btc_side_assigned";