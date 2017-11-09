
private ["_city","_pos","_roads","_marker","_veh_type","_veh","_useful","_area"];

_useful = btc_city_all select {(_x getVariable ["type",""] != "NameMarine")} ;
if (_useful isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};
_city = selectRandom _useful;

_pos = [getPos _city, 100] call btc_fnc_randomize_pos;

_roads = _pos nearRoads 300;

if (count _roads > 0) then {_pos = getPos (selectRandom _roads);};

btc_side_aborted = false;
btc_side_done = false;
btc_side_failed = false;
btc_side_assigned = true;publicVariable "btc_side_assigned";

[5,_pos,_city getVariable "name"] call btc_fnc_task_create;

btc_side_jip_data = [5,_pos,_city getVariable "name"];

_area = createmarker [format ["sm_%1",_pos],_pos];
_area setMarkerShape "ELLIPSE";
_area setMarkerBrush "SolidBorder";
_area setMarkerSize [30, 30];
_area setMarkerAlpha 0.3;
_area setmarkercolor "colorBlue";

_marker = createmarker [format ["sm_2_%1",_pos],_pos];
_marker setmarkertype "hd_flag";
_marker setmarkertext (localize "STR_BTC_HAM_SIDE_VEHICLE_MRK"); // Vehicle needs assistance
_marker setMarkerSize [0.6, 0.6];

_veh_type = selectRandom btc_civ_type_veh;
_veh = createVehicle [_veh_type, _pos, [], 0, "NONE"];

_veh setDir (random 360);

_veh setDamage 0.7;

_veh setHit ["wheel_1_1_steering", 1];

waitUntil {sleep 5; (btc_side_aborted || btc_side_failed || (_veh getHit "wheel_1_1_steering" < 1) || !Alive _veh)};

btc_side_assigned = false;publicVariable "btc_side_assigned";
[[_area,_marker], [_veh], [], []] call btc_fnc_delete;

if (btc_side_aborted || btc_side_failed || !Alive _veh) exitWith {
	5 remoteExec ["btc_fnc_task_fail", 0];
};

15 call btc_fnc_rep_change;

5 remoteExec ["btc_fnc_task_set_done", 0];
