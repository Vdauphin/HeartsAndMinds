
private ["_group","_units","_type_db","_array_pos","_array_type","_side","_array_dam","_behaviour","_array_wp","_array_in_veh","_array_veh","_index_wp","_data"];

_group = _this;

_units = units _group;
_type_db   = 0;
_array_pos    = [];
_array_type   = [];
_side         = str(side (leader _group));
_array_dam    = [];
_behaviour    = [behaviour (leader _group),combatMode _group,formation _group];
_array_wp     = [];
_array_in_veh = [];
_array_veh 	  = [];
_index_wp = 0;
//_group setVariable ["inHouse",true];
{
	_array_pos  = _array_pos + [getpos _x];
	_array_type = _array_type + [typeOf _x];
	_array_dam  = _array_dam + [getDammage _x];
} foreach _units;

_index_wp = (currentWaypoint _group) + 1;
{
	_array_wp = _array_wp + [[waypointPosition _x,waypointType _x,waypointSpeed _x,waypointFormation _x,waypointCombatMode _x,waypointBehaviour _x]];
} foreach waypoints _group;


if (!isNil {_group getVariable "stop"}) then {_type_db = 2;};
if (!isNil {_group getVariable "inHouse"}) then {_type_db = 3;_array_veh = _group getVariable "inHouse";};
if (!isNil {_group getVariable "getWeapons"}) then {_type_db = 4;};
if (!isNil {_group getVariable "suicider"}) then {_type_db = 5;};
/*
if (!isNil {_group getVariable "btc_rebel"}) then {_type_db = 3;};
if (!isNil {_group getVariable "btc_terrorist"}) then {_type_db = 4;};
if (!isNil {_group getVariable "getWeapons"}) then {_type_db = 5;};
*/

if (vehicle leader _group != leader _group) then {_type_db = 1;};

if (_type_db == 1) then
{
	private ["_veh","_type","_pos","_dir","_fuel"];
	_veh = vehicle leader _group;
	_type = typeOf _veh;
	_pos = getposATL _veh;
	_dir = getdir _veh;
	_fuel = fuel _veh;
	_array_veh = [_type,_pos,_dir,_fuel];
	deletevehicle _veh;
};
_data = [_type_db,_array_pos,_array_type,_side,_array_dam,_behaviour,[_index_wp,_array_wp],_array_veh];
{deletevehicle _x} foreach _units;deleteGroup _group;

_data