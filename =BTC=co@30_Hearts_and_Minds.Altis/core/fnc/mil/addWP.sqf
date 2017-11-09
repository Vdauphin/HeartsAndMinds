//[_group,_city,600] call btc_fnc_addWP;

private ["_group","_city","_area","_wp","_pos","_rpos","_in_house"];

_group = _this select 0;
_city = _this select 1;
_area = _this select 2;
_wp = _this select 3;

_pos = [];

switch (typeName _city) do {
	case "ARRAY" :{_pos = _city;};
	case "STRING":{_pos = getMarkerPos _city;};
	case "OBJECT":{_pos = position _city;};
};

_rpos = [_pos, _area] call btc_fnc_randomize_pos;

_in_house = false;

switch (true) do {
	case (_wp < 0.3) : {
		private ["_houses","_house","_n_pos","_max_pos","_unit"];
		_houses = [_city,_area] call btc_fnc_getHouses;
		if (count _houses > 0) then	{
			_in_house = true;
			_house = selectRandom _houses;
			[_group,_house] spawn btc_fnc_house_addWP;
			_group setVariable ["inHouse", typeOf _house];
		} else {[_group,_rpos,_area,"SAFE"] call btc_fnc_task_patrol;};
	};
	case (_wp > 0.3 && _wp < 0.75) : {
		[_group,_rpos,_area,"AWARE"] call btc_fnc_task_patrol;
	};
	case (_wp > 0.75) : {
		private ["_wpa"];
		_wpa = _group addWaypoint [_rpos, 0];
		_wpa setWaypointType "SENTRY";
		_wpa setWaypointCombatMode "RED";
		_wpa setWaypointBehaviour "AWARE";
		_wpa setWaypointFormation "WEDGE";
		_wpa setWaypointTimeout [18000, 36000, 54000];
		_wpa setWaypointStatements ["true","(group this) spawn btc_fnc_data_add_group;"];
	};
};

true