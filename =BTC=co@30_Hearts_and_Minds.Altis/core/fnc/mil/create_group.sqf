
private ["_city","_area","_n","_wp","_pos","_rpos","_unit_type","_group","_pos_iswater","_newpos"];

_city = _this select 0;
_area = _this select 1;
_n = _this select 2;
_wp = _this select 3;

_pos = [];

switch (typeName _city) do {
	case "ARRAY" :{_pos = _city;};
	case "STRING":{_pos = getMarkerPos _city;};
	case "OBJECT":{_pos = position _city;};
};

_rpos = [_pos, _area, btc_p_sea] call btc_fnc_randomize_pos;

_pos_iswater = (surfaceIsWater _rpos);
if (_pos_iswater) then {
	_unit_type = selectRandom btc_type_divers;
} else {
	_unit_type = selectRandom btc_type_units;
	_newpos = _rpos findEmptyPosition [0, 40];
	if !(_newpos isEqualTo []) then {_rpos = _newpos;};
};

_group = createGroup btc_enemy_side;
[_group createUnit [_unit_type, _rpos, [], 0, "NONE"]] joinSilent _group;
(leader _group) setpos _rpos;
private _groups = [];
_groups pushBack _group;
private _structure = objNull;

switch (true) do {
	case (_wp < 0.3) : {
		private _structures = [_rpos,70] call btc_fnc_mil_getStructures;
		if !(_structures isEqualTo []) then	{
			_structure = selectRandom _structures;
			_n = count (_structure buildingPos -1);
			if (_n > 8) then {
				_n = 2;
			} else {
				_n = floor(_n/2);
			};
			for "_i" from 0 to _n do {
				[_group createUnit [selectRandom btc_type_units, _rpos, [], 0, "NONE"]] joinSilent _group;
				sleep 0.5;
			};
		} else {
			private _houses = [_rpos,50] call btc_fnc_getHouses;
			if !(_houses isEqualTo []) then	{
				_structure = selectRandom _houses;
			} else {[_group,_rpos,_area,"SAFE",_pos_iswater] spawn btc_fnc_task_patrol;};
		};
	};
	case (_wp > 0.3 && _wp < 0.75) : {
		[_group,_rpos,_area,"AWARE",_pos_iswater] spawn btc_fnc_task_patrol;
	};
	case (_wp > 0.75) :	{
		private _wpa = _group addWaypoint [_rpos, 0];
		_wpa setWaypointType "SENTRY";
		_wpa setWaypointCombatMode "RED";
		_wpa setWaypointBehaviour "AWARE";
	};
};
if (_structure isEqualTo objNull) then {
	for "_i" from 0 to _n do {
		_unit_type = [selectRandom btc_type_units, selectRandom btc_type_divers ] select _pos_iswater;
		[_group createUnit [_unit_type, _rpos, [], 0, "NONE"]] joinSilent _group;
		sleep 0.5;
	};
	//_group createUnit [btc_type_medic, _pos, [], 0, "NONE"];
} else {
	{
		private _grp = createGroup btc_enemy_side;
		[_x] joinSilent _grp;
		_grp setVariable ["inHouse", typeOf _structure];
		[_grp,_structure] spawn btc_fnc_house_addWP;
		_groups pushBack _grp;
	} forEach units _group;
};

//if ((position leader _group) distance [0,0,0] < 50) then {{_x setpos _rpos;} foreach units _group;};

{_x call btc_fnc_mil_unit_create;} foreach units _group;

if (btc_debug_log) then {diag_log format ["btc_fnc_mil_create_group: _this = %1 ; POS %2 UNITS N %3",_this,_rpos,count units _group];};

_groups