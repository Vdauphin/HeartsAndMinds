
private ["_useful","_city","_pos","_area","_marker","_mines"];

_useful = [];
{if (_x getVariable ["type",""] != "NameLocal" && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine")) then {_useful = _useful + [_x];};} foreach btc_city_all;

if (count _useful == 0) then {_useful = + btc_city_all;};

_city = _useful select (floor random count _useful);

//_pos = [getPos _city, 100] call btc_fnc_randomize_pos;

_pos = [getPos _city, 0, 500, 30, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[[4,_pos,_city getVariable "name"],"btc_fnc_task_create",true] spawn BIS_fnc_MP;

btc_side_jip_data = [4,_pos,_city getVariable "name"];

_area = createmarker [format ["sm_%1",_pos],_pos];
_area setMarkerShape "RECTANGLE";
_area setMarkerBrush "SolidBorder";
_area setMarkerSize [80, 80];
_area setMarkerAlpha 0.3;
_area setmarkercolor "colorBlue";

_marker = createmarker [format ["sm_2_%1",_pos],_pos];
_marker setmarkertype "hd_flag";
_marker setmarkertext "Mines";
_marker setMarkerSize [0.6, 0.6];

_mines = [];

for "_i" from 1 to (5 + round random 5) do {
	private ["_type","_m_pos"];
	_type = "ATMine";
	if (random 1 > 0.6) then {_type = "APERSMine";};
	_m_pos = [_pos, 50] call btc_fnc_randomize_pos;
	_m = createMine [_type, _m_pos, [], 0];
	_mines = _mines + [_m];
};

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || ({!isNull _x} count _mines == 0))};

{deletemarker _x} foreach [_area,_marker];

if (btc_side_aborted || btc_side_failed) exitWith {
	[4,"btc_fnc_task_fail",true] spawn BIS_fnc_MP;
	btc_side_assigned = false;publicVariable "btc_side_assigned";
	{if (!isNull _x) then {deleteVehicle _x}} foreach _mines;
};

30 call btc_fnc_rep_change;

[4,"btc_fnc_task_set_done",true] spawn BIS_fnc_MP;

btc_side_assigned = false;publicVariable "btc_side_assigned";