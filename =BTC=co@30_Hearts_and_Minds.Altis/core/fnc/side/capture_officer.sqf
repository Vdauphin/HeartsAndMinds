/*
Thanks DAP for inspiration.
*/

private ["_usefuls","_city1","_city2","_pos1","_pos2","_area","_marker1","_marker2","_markers","_crewmen","_roads","_road","_veh_type","_vehs","_cargo","_radius_y","_radius_x","_veh_types","_captive","_random","_random_veh","_trigger"];

//// Choose two Cities \\\\
_usefuls = btc_city_all select {((_x getVariable ["type",""] != "NameLocal") && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine") && !(_x getVariable ["occupied",false]))};
if (_usefuls isEqualTo []) then {_usefuls = + btc_city_all;};
_city2 = selectRandom _usefuls;

_area = (getNumber (configFile >> "CfgWorlds" >> worldName >> "MapSize"))/4;
_cities = btc_city_all select {(_x distance _city2 > _area)};
_usefuls = _cities select {((_x getVariable ["type",""] != "NameLocal") && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine") && (_x getVariable ["occupied",false]))};
if (_usefuls isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};
_city1 = selectRandom _usefuls;

//// Find roads \\\\
_radius_x = _city1 getVariable ["RadiusX",0];
_roads = _city1 nearRoads (_radius_x * 2);
_roads = _roads select {(_x distance _city1 > _radius_x ) && isOnRoad _x};
if (_roads isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};
_road = selectRandom _roads;
_pos1 = getPos _road;
_pos2 = getPos _city2;

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[14,_pos2,_city2 getVariable "name"] call btc_fnc_task_create;

btc_side_jip_data = [14,getPos _city1,_city1 getVariable "name"];

//// Create markers \\\\
_marker1 = createmarker [format ["sm_2_%1",getPos _city1],getPos _city1];
_marker1 setmarkertype "hd_flag";
_marker1 setmarkertext (localize "STR_BTC_HAM_SIDE_CONVOY_MRKSTART"); //Convoy Start
_marker1 setMarkerSize [0.6, 0.6];

_marker2 = createmarker [format ["sm_2_%1",_pos2],_pos2];
_marker2 setmarkertype "hd_flag";
_marker2 setmarkertext (localize "STR_BTC_HAM_SIDE_CONVOY_MRKEND"); //Convoy End
_marker2 setMarkerSize [0.6, 0.6];

_area = createmarker [format ["sm_%1",_pos2],_pos2];
_area setMarkerShape "ELLIPSE";
_area setMarkerBrush "SolidBorder";
_area setMarkerSize [_radius_x/1.5, _radius_x/1.5];
_area setMarkerAlpha 0.3;
_area setmarkercolor "colorBlue";

_markers = [_marker1,_marker2,_area];

//// Create convoy \\\\
_group = createGroup btc_enemy_side;
_group setVariable ["no_cache",true];

_vehs = [];
_veh_types = btc_civ_type_veh select {!(_x isKindOf "air")};
_random = (1+ round random 1);
_random_veh = round random _random;
for "_i" from 0 to _random do {
	private ["_veh"];
	_veh_type = selectRandom _veh_types;
	_crewmen = btc_type_crewmen;
	_veh = createVehicle [_veh_type, _pos1, [], 0, "FLY"];
	_veh setDir ([_road] call btc_fnc_road_direction);
	_vehs pushBack _veh;

	[_veh,_group,false,"",_crewmen] call BIS_fnc_spawnCrew;
	if (_i == _random_veh) then {
		(selectRandom btc_type_units) createUnit [_pos1, _group, "this moveinCargo _veh;this assignAsCargo _veh; removeAllWeapons this; _captive = this; _group selectLeader this;"]
	};
	_cargo = (_veh emptyPositions "cargo") - 1;
	if (_cargo > 0) then {
		for "_i" from 0 to _cargo do {
			private ["_unit_type"];
			_unit_type = selectRandom btc_type_units;
			_unit_type createUnit [_pos1, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
		};
	};
	_road = (roadsConnectedTo _road) select 0;
	_pos1 = getPos _road;
};

units _group joinSilent _group;
{_x call btc_fnc_mil_unit_create} foreach units _group;

_group setBehaviour "SAFE";
_wp = _group addWaypoint [_pos2, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius _radius_x/1.5;
_wp setWaypointCombatMode "RED";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointFormation "COLUMN";
_wp setWaypointStatements ["true", "btc_side_failed = true"];

//// Create trigger \\\\
_trigger = createTrigger["EmptyDetector",getPos _city1];
_trigger setVariable ["captive", _captive];
_trigger setTriggerArea[15,15,0,false];
_trigger setTriggerActivation[str(btc_player_side),"PRESENT",true];
_trigger setTriggerStatements["this", "_captive = thisTrigger getVariable 'captive'; doStop _captive; [_captive,true] call ace_captives_fnc_setSurrendered;", ""];
_trigger attachTo [_captive,[0,0,0]];

{player commandChat (localize "STR_BTC_HAM_SIDE_CONVOY_STARTCHAT")} remoteExec ["call", -2]; //Convoy has left the starting point!

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || !(Alive _captive) || (_captive distance getpos btc_create_object_point < 100))};

btc_side_assigned = false;publicVariable "btc_side_assigned";
if (btc_side_aborted || !(Alive _captive)) exitWith {
	14 remoteExec ["btc_fnc_task_fail", 0];
	[_markers, _vehs + [_trigger], [], [_group]] call btc_fnc_delete;
};

if (btc_side_failed) exitWith {
	14 remoteExec ["btc_fnc_task_fail", 0];
	deleteVehicle _trigger;
	_group setVariable ["no_cache",false];
	{
		_group = createGroup btc_enemy_side;
		(crew _x) joinSilent _group;
		_group call btc_fnc_data_add_group;
	} forEach _vehs;
};

50 call btc_fnc_rep_change;

14 remoteExec ["btc_fnc_task_set_done", 0];

[_markers, _vehs + [_trigger,_captive], [], [_group]] call btc_fnc_delete;
