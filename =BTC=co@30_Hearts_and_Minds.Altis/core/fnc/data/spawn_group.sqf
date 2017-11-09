
params ["_type","_array_pos","_array_type","_side","_array_dam","_behaviour","_array_wp","_array_veh"];

private _group = createGroup _side;

for "_i" from 0 to (count _array_pos - 1) do {
	private _u = _group createUnit [(_array_type select _i), (_array_pos select _i), [], 0, "NONE"];
	_u enableSimulation false;
	_u setPosATL (_array_pos select _i);
	if (btc_debug_log) then {diag_log format ["spawn group : pos %1 in %2 ", (_array_pos select _i),getpos _u];};
	_u setDamage (_array_dam select _i);
};

if (_type == 1) then {
	private _veh = createVehicle [(_array_veh select 0), (_array_veh select 1), [], 0, "FLY"];
	if !(_veh isKindOf "Plane") then {
		_veh setPosATL (_array_veh select 1);
		_veh setDir (_array_veh select 2);
	};
	_veh setFuel (_array_veh select 3);
	{
		private _assigned = false;
		if (!_assigned && _veh emptyPositions "driver" > 0) then {_x moveInDriver _veh;_x assignAsDriver _veh;_assigned = true;};
		if (!_assigned && _veh emptyPositions "gunner" > 0) then {_x moveinGunner _veh;_x assignAsGunner _veh;_assigned = true;};
		if (!_assigned && _veh emptyPositions "commander" > 0) then {_x moveinCommander _veh;_x assignAsCommander _veh;_assigned = true;};
		if (!_assigned && _veh emptyPositions "cargo" > 0) then {_x moveinCargo _veh;_x assignAsCargo _veh;_assigned = true;};
	} foreach units _group;
};

units _group joinSilent _group;
(units _group) apply {_x enableSimulation true};

//[waypointPosition _x,waypointType _x,waypointSpeed _x,waypointFormation _x,waypointCombatMode _x,waypointBehaviour _x]
if !(_side == civilian && {vehicle leader _group == leader _group}) then {
	if (count (_array_wp select 1) > 1) then {
		{
			//diag_log text format ["TEST X %1",_x];
			private _wp = _group addWaypoint [(_x select 0), 0];
			_wp setWaypointCompletionRadius 20;
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
	[_group, nearestObject [(units _group) select 0, _array_veh]] spawn btc_fnc_house_addWP;
	_group setVariable ["inHouse", _array_veh];
};
if (_type == 4) then {[[0,0,0],0,units _group] spawn btc_fnc_civ_get_weapons;};
if (_type == 5) then {
	_group spawn {
		_this setVariable ["suicider",true];

		private _suicider = leader _this;

		//Main check

		private _cond = false;

		while {Alive _suicider && !isNull _suicider && !_cond} do {
			sleep 5;
			if (count (getpos _suicider nearEntities ["SoldierWB", 25]) > 0) then {_cond = true;_suicider spawn btc_fnc_ied_suicider_active};
		};
	};
};
if (_type == 6) then {
	while {(count (waypoints _group)) > 0} do { deleteWaypoint ((waypoints _group) select 0); };
	[_group, _array_veh select 0] spawn btc_fnc_civ_addWP;
	_group setVariable ["btc_data_inhouse", _array_veh];
};

_group setBehaviour (_behaviour select 0);
_group setCombatMode (_behaviour select 1);
_group setFormation (_behaviour select 2);

if (_side == btc_enemy_side) then {{_x call btc_fnc_mil_unit_create} foreach units _group;};
if (_side == civilian) then {{_x call btc_fnc_civ_unit_create} foreach units _group;};