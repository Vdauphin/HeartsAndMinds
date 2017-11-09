
private ["_useful","_city","_pos","_marker","_wrecks","_generator","_objects","_storagebladder","_area","_group"];

//// Choose a Marine location occupied \\\\
_useful = btc_city_all select {((_x getVariable ["occupied",false]) && (_x getVariable ["type",""] == "NameMarine"))};
if (_useful isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};

_city = selectRandom _useful;

//// Choose a random position \\\\
_objects = nearestobjects [getpos _city,[], 200];

_objects = _objects select {(!((str(_x) find "wreck") isEqualTo -1) || !((str(_x) find "broken") isEqualTo -1) || !((str(_x) find "rock") isEqualTo -1))};
_objects = _objects select {((getPos _x select 2 < -3) && (((str(_x) find "car") isEqualTo -1) || ((str(_x) find "uaz") isEqualTo -1)))};
_wrecks = _objects select {((str(_x) find "rock") isEqualTo -1)};

if (_wrecks isEqualTo []) then {
	if (_objects isEqualTo []) then {
		_pos = [getPos _city, 0, 100, 13, 2, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
		_pos = [_pos select 0, _pos select 1, (getTerrainHeightASL [_pos select 0, _pos select 1])];
	} else {
		_pos = getpos (selectRandom _objects);
	};
} else {
	_pos = getpos (selectRandom _wrecks);
};

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[11,_pos,_city getVariable "name"] call btc_fnc_task_create;

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
_marker setmarkertext (localize "STR_BTC_HAM_SIDE_UNDERWATER_MRK"); //Generator
_marker setMarkerSize [0.6, 0.6];


//// Create underwater generator \\\\
_generator = (selectRandom btc_type_generator) createVehicle _pos;
_storagebladder = (selectRandom btc_type_storagebladder) createVehicle [(_pos select 0) + 5, _pos select 1, _pos select 2];

_group = [_pos,8, 1 + round random 5,0.8] call btc_fnc_mil_create_group;
[_pos,20, 2 + round random 4,0.5] call btc_fnc_mil_create_group;

_pos = getPosASL _generator;
leader _group setPosASL [_pos select 0, _pos select 1, (_pos select 2) + 1 + random 1];

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || !Alive _generator )};

[[_area,_marker], [_generator,_storagebladder], [], []] call btc_fnc_delete;
btc_side_assigned = false;publicVariable "btc_side_assigned";

if (btc_side_aborted || btc_side_failed ) exitWith {
	11 remoteExec ["btc_fnc_task_fail", 0];
};

80 call btc_fnc_rep_change;

11 remoteExec ["btc_fnc_task_set_done", 0];
