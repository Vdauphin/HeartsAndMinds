
private ["_type","_array_pos","_array_type","_side","_array_dam","_behaviour","_array_wp","_array_veh","_group"];

_type 		= _this select 0;
_array_pos  = _this select 1;
_array_type = _this select 2;
_side		= _this select 3;
_array_dam  = _this select 4;
_behaviour  = _this select 5;
_array_wp   = _this select 6;
_array_veh  = _this select 7;

_group = createGroup _side;

for "_i" from 0 to (count _array_pos - 1) do {
	private ["_u"];
	_u = _group createUnit [(_array_type select _i), (_array_pos select _i), [], 0, "NONE"];_u setPos (_array_pos select _i);
	_u setDamage (_array_dam select _i);
};

if (_type == 1) then {
	private ["_veh"];
	_veh = (_array_veh select 0) createVehicle (_array_veh select 1);
	_veh setPos (_array_veh select 1);
	_veh setDir (_array_veh select 2);
	_veh setFuel (_array_veh select 3);
	{
		private ["_assigned"];
		_assigned = false;
		if (!_assigned && _veh emptyPositions "driver" > 0) then {_x moveInDriver _veh;_x assignAsDriver _veh;_assigned = true;};
		if (!_assigned && _veh emptyPositions "gunner" > 0) then {_x moveinGunner _veh;_x assignAsGunner _veh;_assigned = true;};
		if (!_assigned && _veh emptyPositions "commander" > 0) then {_x moveinCommander _veh;_x assignAsCommander _veh;_assigned = true;};
		if (!_assigned && _veh emptyPositions "cargo" > 0) then {_x moveinCargo _veh;_x assignAsCargo _veh;_assigned = true;};
	} foreach units _group;
};

//[waypointPosition _x,waypointType _x,waypointSpeed _x,waypointFormation _x,waypointCombatMode _x,waypointBehaviour _x]
if (_side == civilian && {vehicle leader _group == leader _group}) then {
	_group spawn btc_fnc_civ_addWP;
} else {
	if (count (_array_wp select 1) > 1) then {
		{
			private "_wp";
			//diag_log text format ["TEST X %1",_x];
			_wp = _group addWaypoint [(_x select 0), 0];
			_wp setWaypointType (_x select 1);
			_wp setWaypointSpeed (_x select 2);
			_wp setWaypointFormation (_x select 3);
			_wp setWaypointCombatMode (_x select 4);
			_wp setWaypointBehaviour (_x select 5);
		} foreach (_array_wp select 1);
		_group setcurrentWaypoint [_group,(_array_wp select 0)];
	};
};
if (_type == 2) then {
	_group setVariable ["stop",true];
	while {(count (waypoints _group)) > 0} do { deleteWaypoint ((waypoints _group) select 0); };
	{doStop _x;} foreach units _group;
};
if (_type == 3) then {
	while {(count (waypoints _group)) > 0} do { deleteWaypoint ((waypoints _group) select 0); };
	[_group,_array_veh] spawn btc_fnc_house_addWP;
};
if (_type == 4) then {[[0,0,0],0,units _group] spawn btc_fnc_civ_get_weapons;};
if (_type == 5) then {
	_group spawn {
		_this setVariable ["suicider",true];

		_suicider = leader _this;

		//Main check

		_cond = false;

		while {Alive _suicider && !isNull _suicider && !_cond} do {
			sleep 5;
			if (count (getpos _suicider nearEntities ["SoldierWB", 25]) > 0) then {_cond = true;_suicider spawn btc_fnc_ied_suicider_active};
		};	
	};
};

_group setBehaviour (_behaviour select 0);
_group setCombatMode (_behaviour select 1);
_group setFormation (_behaviour select 2);

if (_side == btc_enemy_side) then {{_x call btc_fnc_mil_unit_create} foreach units _group;};