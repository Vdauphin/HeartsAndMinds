
private ["_random","_city","_area","_cities","_useful","_pos","_group"];

_random = _this select 0;//0 random, 1 inf, 2 moto, 3 heli
_city = _this select 1;
_area = _this select 2;

if (isNil "btc_patrol_id") then {btc_patrol_id = 0;};

btc_patrol_active = btc_patrol_active + 1;

if (btc_debug_log) then {diag_log format ["btc_fnc_mil_patrol_create: _random = %1 _city %2 _area %3 btc_patrol_active = %4",_random,_city,_area,btc_patrol_active];};

if (_random == 0) then {
	private ["_n"];
	_n = random 100;
	switch (true) do {
		case (_n < 40)            : {_random = 1;};
		case (_n > 40 && _n < 90) : {_random = 2;};
		case (_n > 90 && _n < 96) : {_random = 3;};
		case (_n > 96)            : {_random = 4;};
	};
};
_cities = [];
{if (_x distance _city < _area) then {_cities = _cities + [_x];};} foreach btc_city_all;
_useful = [];
{if (!(_x getVariable ["active",false]) && _x getVariable ["occupied",false]) then {_useful = _useful + [getPos _x];};} foreach _cities;

/*
if (count _useful == 0) then {
	while {count _useful == 0} do {
		private "_pos";
		_pos = [getPos _city, _area] call btc_fnc_randomize_pos;
		if ({_x distance _pos < 500} count playableUnits == 0) then {_useful = _useful + [_pos];};
	};
};
*/

if (count _useful == 0) exitWith {true};

_pos = _useful select (floor random count _useful);

_group = createGroup btc_enemy_side;
_group setVariable ["city",_city];
_group setVariable ["no_cache",true];
_group setVariable ["btc_patrol",true];
_group setVariable ["btc_patrol_id",btc_patrol_id];btc_patrol_id = btc_patrol_id + 1;

switch (true) do {
	case (_random == 1) : {
		_n_units   = 4 + (round random 8);
		_group createUnit [(btc_type_units select 0), _pos, [], 0, "NONE"];(leader _group) setpos _pos;
		for "_i" from 1 to _n_units do {
			private ["_unit_type"];
			_unit_type = btc_type_units select (floor random count btc_type_units);
			_group createUnit [_unit_type, _pos, [], 0, "NONE"];
			sleep 0.1;
		};
		_spawn = [_group,_area] spawn btc_fnc_mil_patrol_addWP;	
	};
	case (_random == 2) : {
		private ["_veh_type","_newZone","_veh","_cargo"];
		_veh_type = btc_type_motorized select (floor (random (count btc_type_motorized)));
		_newZone = [];
		if (count (_pos nearRoads 150) > 0) then {_newZone = getPos ((_pos nearRoads 150) select 0)} else {_newZone = [_pos, 0, 500, 13, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;};
		_veh = createVehicle [_veh_type, _newZone, [], 0, "NONE"];
		[_veh,_group,false,"",btc_type_crewmen] call BIS_fnc_spawnCrew;
		_group selectLeader (driver _veh);
		_cargo = (_veh emptyPositions "cargo") - 1;
		if (_cargo > 0) then {
			for "_i" from 0 to _cargo do {
				_unit_type = btc_type_units select (round (random ((count btc_type_units) - 1)));
				_unit_type createUnit [_pos, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
			};
		};
		_spawn = [_group,_area] spawn btc_fnc_mil_patrol_addWP;	
	};
};

{_x call btc_fnc_mil_unit_create} foreach units _group;