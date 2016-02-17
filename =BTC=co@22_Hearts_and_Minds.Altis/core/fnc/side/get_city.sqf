
private ["_useful","_city","_pos"];

_useful = [];
{if (_x getVariable ["occupied",false] && {_x getVariable ["type",""] != "NameLocal"} && {_x getVariable ["type",""] != "Hill"} && (_x getVariable ["type",""] != "NameMarine")) then {_useful = _useful + [_x];};} foreach btc_city_all;

if (count _useful == 0) exitWith {[] spawn btc_fnc_side_create;};

_city = _useful select (floor random count _useful);

_pos = getPos _city;

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[[6,_pos,_city getVariable "name"],"btc_fnc_task_create",true] spawn BIS_fnc_MP;

btc_side_jip_data = [6,_pos,_city getVariable "name"];

_city setVariable ["spawn_more",true];

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || !(_city getVariable ["occupied",false]))};


if (btc_side_aborted || btc_side_failed) exitWith {
	[6,"btc_fnc_task_fail",true] spawn BIS_fnc_MP;
	btc_side_assigned = false;publicVariable "btc_side_assigned";
};

80 call btc_fnc_rep_change;

[6,"btc_fnc_task_set_done",true] spawn BIS_fnc_MP;

btc_side_assigned = false;publicVariable "btc_side_assigned";