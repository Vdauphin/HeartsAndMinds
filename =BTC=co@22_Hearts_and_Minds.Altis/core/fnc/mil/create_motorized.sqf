//MOT
private ["_pos","_veh_type","_veh","_gunner","_commander","_cargo","_wp"];
_start_pos = _this select 0;
if (count (_start_pos nearRoads 100) > 0) then {_pos = getPos ((_start_pos nearRoads 100) select 0)} else {_pos = [_start_pos, 10, 100, 13, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;};
_group = createGroup btc_enemy_side;
_group setVariable ["no_cache",true];
_veh_type = btc_type_motorized select (floor random count btc_type_motorized);
_veh = createVehicle [_veh_type, _start_pos, [], 0, "NONE"];
_gunner = _veh emptyPositions "gunner";
_commander = _veh emptyPositions "commander";
_cargo = (_veh emptyPositions "cargo") - 1;

btc_type_crewmen createUnit [_start_pos, _group, "this moveinDriver _veh;this assignAsDriver _veh;"];
if (_gunner > 0) then {btc_type_crewmen createUnit [_start_pos, _group, "this moveinGunner _veh;this assignAsGunner _veh;"];};
if (_commander > 0) then {btc_type_crewmen createUnit [_start_pos, _group, "this moveinCommander _veh;this assignAsCommander _veh;"];};
for "_i" from 0 to _cargo do
{
	_unit_type = btc_type_units select (round (random ((count btc_type_units) - 1)));
	_unit_type createUnit [_start_pos, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
};

_group selectLeader (driver _veh);

_wp = _group addWaypoint [_pos, 60];
_wp setWaypointType "MOVE";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointStatements ["true","(group this) spawn btc_fnc_data_add_group;"];
_wp_1 = _group addWaypoint [_pos, 60];
_wp_1 setWaypointType "UNLOAD";
_wp_2 = _group addWaypoint [_start_pos, 60];
_wp_2 setWaypointType "SAD";
if (btc_debug_log) then
{
	diag_log format ["fnc_rep_call_militia = MOT %1/%2 POS %3",_group,_veh_type,_pos];
};