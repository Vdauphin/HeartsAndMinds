//[_hd,_closest,1,"I_Truck_02_transport_F"] spawn btc_fnc_mil_send;

private ["_pos","_dest"];

_pos = getPos (_this select 0);
_dest = getPos (_this select 1);

switch (_this select 2) do {
	case 0 : {
		private ["_group","_wp_0","_wp"];
		_group = [_pos,150,(3 + random 6),1] call btc_fnc_mil_create_group;
		_group setVariable ["no_cache",true];
		while {(count (waypoints _group)) > 0} do { deleteWaypoint ((waypoints _group) select 0); };
		_wp_0 = _group addWaypoint [_dest, 60];
		_wp = _group addWaypoint [_dest, 60];
		_wp setWaypointType "MOVE";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointFormation "COLUMN";
		_wp setWaypointStatements ["true", "(group this) spawn btc_fnc_data_add_group;"];
	};
	case 1 : {
		private ["_group","_veh_type","_return_pos","_veh","_gunner","_commander","_cargo","_wp","_wp_1","_wp_3"];
		_group = createGroup btc_enemy_side;
		_group setVariable ["no_cache",true];
		_veh_type = (_this select 3);
		if (_veh_type == "") then {_veh_type = btc_type_motorized select (floor random count btc_type_motorized)};
		_return_pos = [_pos, 0, 500, 13, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
		_veh = createVehicle [_veh_type, _return_pos, [], 0, "NONE"];
		_gunner = _veh emptyPositions "gunner";
		_commander = _veh emptyPositions "commander";
		_cargo = (_veh emptyPositions "cargo") - 1;
		btc_type_crewmen createUnit [_pos, _group, "this moveinDriver _veh;this assignAsDriver _veh;"];
		if (_gunner > 0) then {btc_type_crewmen createUnit [_pos, _group, "this moveinGunner _veh;this assignAsGunner _veh;"];};
		if (_commander > 0) then {btc_type_crewmen createUnit [_pos, _group, "this moveinCommander _veh;this assignAsCommander _veh;"];};
		for "_i" from 0 to _cargo do {
			private "_unit_type";
			_unit_type = btc_type_units select (floor random count btc_type_units);
			_unit_type createUnit [_pos, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
		};
		
		_group selectLeader (driver _veh);
		
		_wp = _group addWaypoint [_dest, 60];
		_wp setWaypointType "MOVE";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointSpeed "FULL";
		_wp_1 = _group addWaypoint [_dest, 60];
		_wp_1 setWaypointType "GET OUT";
		_wp_3 = _group addWaypoint [_dest, 60];
		_wp_3 setWaypointType "SENTRY";
		_wp setWaypointStatements ["true","(group this) spawn btc_fnc_data_add_group;"];
		
		{_x call btc_fnc_mil_unit_create} foreach units _group;
	};
};