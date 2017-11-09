
private ["_city","_area","_cities","_useful","_veh_type","_group","_veh","_pos_iswater","_pos","_Spos","_1","_2","_3"];

_city = _this select 0;
_area = _this select 1;

if (isNil "btc_traffic_id") then {btc_traffic_id = 0;};

_cities = btc_city_all select {(_x distance _city < _area)};
_useful = _cities select {!(_x getVariable ["active",false])};
if (_useful isEqualTo []) then {
	while {_useful isEqualTo []} do {
		private "_pos";
		_pos = [getPos _city, _area, btc_p_sea] call btc_fnc_randomize_pos;
		if ({_x distance _pos < 500} count playableUnits isEqualTo 0) then {_useful pushBack _pos;};
	};
	_pos = selectRandom _useful;
} else {
	_pos = getPos(selectRandom _useful);
};

if ((_pos nearRoads 200) isEqualTo []) then {
	_Spos = [_pos, 0, 500, 13, [0,1] select btc_p_sea, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
	_Spos = [_Spos select 0, _Spos select 1, 0];
	_pos_iswater = (surfaceIsWater _Spos);
	if (_pos_iswater) then {
		_veh_type = selectRandom btc_civ_type_boats;
	} else {
		_veh_type = selectRandom btc_civ_type_veh;
	};
} else {
	_Spos = getPos (selectRandom (_pos nearRoads 200));
	_pos_iswater = false;
	_veh_type = selectRandom btc_civ_type_veh;
};

_veh = createVehicle [_veh_type, _Spos, [], 0, "FLY"];
[_veh, "", []] call BIS_fnc_initvehicle;

_group = createGroup [civilian, true];
(selectRandom btc_civ_type_units) createUnit [_Spos, _group, "this moveinDriver _veh; this assignAsDriver _veh;"];
_group setVariable ["no_cache",true];
_group setVariable ["btc_patrol",true];
_group setVariable ["btc_traffic_id",btc_traffic_id,btc_debug];btc_traffic_id = btc_traffic_id + 1;
_group setVariable ["city",_city];

btc_civ_veh_active pushBack _group;

_veh setVariable ["driver", _group];

{_x call btc_fnc_civ_unit_create;_x setVariable ["traffic",_veh];} foreach units _group;

_1 = _veh addEventHandler ["HandleDamage", {if ((_this select 2) > 0.1) then {_this call btc_fnc_civ_traffic_eh}}];
_2 = _veh addEventHandler ["Fuel", {_this call btc_fnc_civ_traffic_eh}];
_3 = _veh addEventHandler ["GetOut", {_this call btc_fnc_civ_traffic_eh}];
//_4 = (leader _group) addEventHandler ["HandleDamage", {_this call btc_fnc_civ_traffic_eh}];
//_5 = (leader _group) addEventHandler ["Killed", {_this call btc_fnc_civ_traffic_eh}];

_veh setVariable ["eh", [_1,_2,_3/*,4,5*/]];
[_group,_area,_pos_iswater] call btc_fnc_civ_traffic_add_WP;