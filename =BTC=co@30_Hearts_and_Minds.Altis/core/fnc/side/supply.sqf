
private ["_useful","_city","_pos","_area","_marker"];

_useful = btc_city_all select {(_x getVariable ["type",""] != "NameLocal" && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine"))} ;

if (_useful isEqualTo []) then {_useful = + btc_city_all;};

_city = selectRandom _useful;

_pos = [getPos _city, 100] call btc_fnc_randomize_pos;

_pos = [_pos, 0, 300, 20, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[3,_pos,_city getVariable "name"] call btc_fnc_task_create;

btc_side_jip_data = [3,_pos,_city getVariable "name"];

_area = createmarker [format ["sm_%1",_pos],_pos];
_area setMarkerShape "ELLIPSE";
_area setMarkerBrush "SolidBorder";
_area setMarkerSize [30, 30];
_area setMarkerAlpha 0.3;
_area setmarkercolor "colorBlue";

_marker = createmarker [format ["sm_2_%1",_pos],_pos];
_marker setmarkertype "hd_flag";
_marker setmarkertext (localize "STR_BTC_HAM_SIDE_SUPPLIES_MRK"); //Supplies
_marker setMarkerSize [0.6, 0.6];

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || count (nearestObjects [_pos, [btc_supplies_mat], 30]) > 0)};

btc_side_assigned = false;publicVariable "btc_side_assigned";

if (btc_side_aborted || btc_side_failed) exitWith {
	3 remoteExec ["btc_fnc_task_fail", 0];
	[[_area,_marker], [], [], []] call btc_fnc_delete;
};

50 call btc_fnc_rep_change;

3 remoteExec ["btc_fnc_task_set_done", 0];

[[_area,_marker], [(nearestObjects [_pos, [btc_supplies_mat], 30]) select 0], [], []] call btc_fnc_delete;
