
private ["_city","_area","_n","_wp","_pos","_rpos","_unit_type","_group","_in_house","_pos_iswater"];

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
	_unit_type = btc_type_divers select (floor random count btc_type_divers);
} else {
	_unit_type = btc_type_units select (floor random count btc_type_units);
};

_group = createGroup btc_enemy_side;
_group createUnit [_unit_type, _rpos, [], 0, "NONE"];
(leader _group) setpos _rpos;
_in_house = false;

switch (true) do {
	case (_wp < 0.3) : {
		private ["_houses","_house","_n_pos","_max_pos","_unit"];
		_houses = [_rpos,50] call btc_fnc_getHouses;
		if (count _houses > 0) then	{
			_in_house = true;
			_house = _houses select (floor random count _houses);
			[_group,_house] spawn btc_fnc_house_addWP;
			_group setVariable ["inHouse",_house];
		} else {[_group,_rpos,_area,"SAFE",_pos_iswater] spawn btc_fnc_task_patrol;};
	};
	case (_wp > 0.3 && _wp < 0.75) : {
		[_group,_rpos,(_area*2),"AWARE",_pos_iswater] spawn btc_fnc_task_patrol;
	};
	case (_wp > 0.75) :	{
		private ["_wpa"];
		_wpa = _group addWaypoint [_rpos, 0];
		_wpa setWaypointType "SENTRY";
		_wpa setWaypointCombatMode "RED";
		_wpa setWaypointBehaviour "AWARE";
	};
};
if (!_in_house) then {
	for "_i" from 0 to _n do {
		_unit_type = [btc_type_units select (floor random count btc_type_units), btc_type_divers select (floor random count btc_type_divers) ] select _pos_iswater;
		_group createUnit [_unit_type, _rpos, [], 0, "NONE"];
		sleep 0.5;
	};
	//_group createUnit [btc_type_medic, _pos, [], 0, "NONE"];
};

if ((position leader _group) distance [0,0,0] < 50) then {{_x setpos _rpos;} foreach units _group;};

{_x call btc_fnc_mil_unit_create;} foreach units _group;

if (btc_debug_log) then {diag_log format ["btc_fnc_mil_create_group: _this = %1 ; POS %2 UNITS N %3",_this,_rpos,count units _group];};

_group