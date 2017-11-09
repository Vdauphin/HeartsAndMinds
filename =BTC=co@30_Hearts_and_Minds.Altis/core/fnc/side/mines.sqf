
private ["_useful","_city","_pos","_area","_marker","_mines","_closest"];

_useful = btc_city_all select {((_x getVariable ["type",""] != "NameLocal") && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine"))};

if (_useful isEqualTo []) then {_useful = + btc_city_all;};

_city = selectRandom _useful;

//_pos = [getPos _city, 100] call btc_fnc_randomize_pos;

_pos = [getPos _city, 0, 500, 30, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[4,_pos,_city getVariable "name"] call btc_fnc_task_create;

btc_side_jip_data = [4,_pos,_city getVariable "name"];

_area = createmarker [format ["sm_%1",_pos],_pos];
_area setMarkerShape "RECTANGLE";
_area setMarkerBrush "SolidBorder";
_area setMarkerSize [60, 60];
_area setMarkerAlpha 0.3;
_area setmarkercolor "colorBlue";

_marker = createmarker [format ["sm_2_%1",_pos],_pos];
_marker setmarkertype "hd_flag";
_marker setmarkertext (localize "STR_BTC_HAM_SIDE_MINES_MRK"); //Mines
_marker setMarkerSize [0.6, 0.6];

_mines = [];

for "_i" from 1 to (5 + round random 5) do {
	private ["_type","_m_pos"];
	_type = "ATMine";
	if (random 1 > 0.6) then {_type = selectRandom btc_type_mines;};
	_m_pos = [_pos, 50] call btc_fnc_randomize_pos;
	_m = createMine [_type, _m_pos, [], 0];
	_mines pushBack _m;
};

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || ({_x distance _pos < 200} count playableUnits > 0))};

_closest = [_city,btc_city_all select {!(_x getVariable ["active",false])},false] call btc_fnc_find_closecity;
for "_i" from 1 to (round random 2) do {
	[_closest,_pos,1,selectRandom btc_type_motorized] spawn btc_fnc_mil_send;
};

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || ({!isNull _x} count _mines == 0))};

btc_side_assigned = false;publicVariable "btc_side_assigned";
if (btc_side_aborted || btc_side_failed) exitWith {
	4 remoteExec ["btc_fnc_task_fail", 0];
	[[_area,_marker], _mines, [], []] call btc_fnc_delete;
};

30 call btc_fnc_rep_change;

4 remoteExec ["btc_fnc_task_set_done", 0];

[[_area,_marker], [], [], []] call btc_fnc_delete;
