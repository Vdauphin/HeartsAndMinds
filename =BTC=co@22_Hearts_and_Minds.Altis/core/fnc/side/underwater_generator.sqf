
private ["_useful","_city","_pos","_road","_roads","_marker","_statics","_underwater_generator_type","_generator","_direction"];

//// Choose a Marine location \\\\
_useful = [];
{if ((_x getVariable ["occupied",false]) && (_x getVariable ["type",""] == "NameMarine"))  then {_useful pushBack _x;};} foreach btc_city_all;
if (count _useful == 0) exitWith {[] spawn btc_fnc_side_create;};

_city = _useful select (floor random count _useful);

//// Choose a random position \\\\
_pos = [getPos _city, 100] call btc_fnc_randomize_pos;

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[[11,_pos,_city getVariable "name"],"btc_fnc_task_create",true] spawn BIS_fnc_MP;

btc_side_jip_data = [11,_pos,_city getVariable "name"];

_city setVariable ["spawn_more",true];

//// Create marker \\\\
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


//// Create underwater generator \\\\
"StorageBladder_02_water_sand_F"
_underwater_generator_type = btc_type_generator select (floor (random (count btc_type_generator)));

_generator = createVehicle [_underwater_generator_type, _pos, [], 0, "NONE"];
_generator setPos (_pos);

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || !Alive _generator )};

{deletemarker _x} foreach [_area,_marker];

if (btc_side_aborted || btc_side_failed ) exitWith {
	[11,"btc_fnc_task_fail",true] spawn BIS_fnc_MP;
	btc_side_assigned = false;publicVariable "btc_side_assigned";
	_generator spawn {

		waitUntil {sleep 5; ({_x distance _this < 300} count playableUnits == 0)};

		deleteVehicle _this;
	};
};

80 call btc_fnc_rep_change;

[11,"btc_fnc_task_set_done",true] spawn BIS_fnc_MP;

_generator spawn {

	waitUntil {sleep 5; ({_x distance _this < 300} count playableUnits == 0)};

	deleteVehicle _this;
};


btc_side_assigned = false;publicVariable "btc_side_assigned";