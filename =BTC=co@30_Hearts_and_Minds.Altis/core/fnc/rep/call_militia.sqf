
private ["_pos","_players","_start_pos","_ratio","_wp_2","_wp_1"];

btc_rep_militia_called = time;
_pos = _this select 0;

_players = if (isMultiplayer) then {playableUnits} else {switchableunits};

//is there an hideout close by?
_start_pos = [];
{
	private ["_hideout"];
	_hideout = _x;
	if (_pos distance _hideout < 2000 && {{_x distance _hideout < 500} count _players == 0}) then {_start_pos = getPos _hideout;};
} foreach btc_hideouts;

if (btc_debug_log) then {diag_log format ["fnc_rep_call_militia = _start_pos : %1 (HIDEOUTS)",_start_pos];};

if (count _start_pos == 0) then
{
	{
		private ["_city"];
		_city = _x;
		if (_pos distance _city > 300 && {_pos distance _city < 2500} && {{_x distance _city < 500} count _players == 0}) then {_start_pos = getPos _city;};
	} foreach btc_city_all;
};
if (btc_debug_log) then {diag_log format ["fnc_rep_call_militia = _start_pos : %1 (CITIES)",_start_pos];};

if (count _start_pos == 0) then
{
	private ["_random"];
	_random = random 8;
	switch (true) do
	{
		case (_random <= 1) : {_start_pos = [(_pos select 0) + 0,(_pos select 1) + 1000,0];};//N
		case (_random > 1 && _random <= 2) : {_start_pos = [(_pos select 0) + 750,(_pos select 1) + 750,0];};//NE
		case (_random > 2 && _random <= 3) : {_start_pos = [(_pos select 0) + 1000,(_pos select 1) + 0,0];};//E
		case (_random > 3 && _random <= 4) : {_start_pos = [(_pos select 0) + 750,(_pos select 1) - 750,0];};//SE
		case (_random > 4 && _random <= 5) : {_start_pos = [(_pos select 0) - 1000,(_pos select 1) + 0,0];};//W
		case (_random > 5 && _random <= 6) : {_start_pos = [(_pos select 0) - 750,(_pos select 1) - 750,0];};//SW
		case (_random > 6 && _random <= 7) : {_start_pos = [(_pos select 0) - 750,(_pos select 1) + 750,0];};//NW
		case (_random > 7) : {_start_pos = [(_pos select 0) + 0,(_pos select 1) - 1000,0];};//S
	};
};

if (btc_debug_log) then {diag_log format ["fnc_rep_call_militia = _start_pos : %1 (ULTIMA RATIO)",_start_pos];};

_ratio = if (_pos distance _start_pos > 1000) then {0.2} else {0.6};

if (btc_debug_log) then
{
	diag_log format ["fnc_rep_call_militia = POS : %1 STARTPOS : %2 - RATIO = %3",_pos,_start_pos,_ratio];
};

if ((random 1) > _ratio) then
{
	//MOT
	private ["_veh_type","_veh","_gunner","_commander","_cargo","_wp"];
	_group = createGroup btc_enemy_side;
	_group setVariable ["no_cache",true];
	_veh_type = selectRandom btc_type_motorized;
	_veh = createVehicle [_veh_type, _start_pos, [], 0, "FLY"];
	_gunner = _veh emptyPositions "gunner";
	_commander = _veh emptyPositions "commander";
	_cargo = (_veh emptyPositions "cargo") - 1;
	btc_type_crewmen createUnit [_start_pos, _group, "this moveinDriver _veh;this assignAsDriver _veh;"];
	if (_gunner > 0) then {btc_type_crewmen createUnit [_start_pos, _group, "this moveinGunner _veh;this assignAsGunner _veh;"];};
	if (_commander > 0) then {btc_type_crewmen createUnit [_start_pos, _group, "this moveinCommander _veh;this assignAsCommander _veh;"];};
	for "_i" from 0 to _cargo do
	{
		_unit_type = selectRandom btc_type_units;
		_unit_type createUnit [_start_pos, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
	};

	units _group joinSilent _group;
	_group selectLeader (driver _veh);

	_wp = _group addWaypoint [_pos, 60];
	_wp setWaypointType "MOVE";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointStatements ["true","(group this) spawn btc_fnc_data_add_group;"];
	_wp_1 = _group addWaypoint [_pos, 60];
	_wp_1 setWaypointType "UNLOAD";
	_wp_2 = _group addWaypoint [_pos, 60];
	_wp_2 setWaypointType "SAD";
	if (btc_debug_log) then
	{
		diag_log format ["fnc_rep_call_militia = MOT %1/%2 POS %3",_group,_veh_type,_pos];
	};
}
else
{
	//INF
	_group = [_start_pos,50,(8 + random 6),1] call btc_fnc_mil_create_group;
	_group setVariable ["no_cache",true];
	while {(count (waypoints _group)) > 0} do { deleteWaypoint ((waypoints _group) select 0); };
	_wp = _group addWaypoint [_pos, 60];
	_wp setWaypointType "MOVE";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointFormation "WEDGE";
	_wp setWaypointStatements ["true", "(group this) spawn btc_fnc_data_add_group;"];
	//hint format ["%1,%2,%3,%4",_group,_pos,_wp,waypoints _group];
	_wp_2 = _group addWaypoint [_pos, 60];
	_wp_2 setWaypointType "SAD";
	if (btc_debug_log) then
	{
		diag_log format ["fnc_rep_call_militia = INF %1",_group];
	};
};