/*
profileNamespace setVariable ["var_kills",10000];
saveProfileNamespace;
_playerKills = profileNamespace getVariable "var_kills";*/

private ["_cities_status","_fobs"];

hint "saving...";
[[8],"btc_fnc_show_hint"] spawn BIS_fnc_MP;

btc_db_is_saving = true;

profileNamespace setVariable ["btc_hm_date",date];

for "_i" from 0 to (count btc_city_all - 1) do {
	private "_s";
	_s = [_i] spawn btc_fnc_city_de_activate;
	waitUntil {scriptDone _s};
};
hint "saving...2";
//City status
_cities_status = [];
{
	_city_status = [];
	_city_status pushBack (_x getVariable "id");
	
	//_city_status pushBack (_x getVariable "name");
	
	_city_status pushBack (_x getVariable "initialized");

	_city_status pushBack (_x getVariable "spawn_more");
	_city_status pushBack (_x getVariable "occupied");
	
	_city_status pushBack (_x getVariable "data_units");
	
	_city_status pushBack (_x getVariable ["has_ho",false]);
	_city_status pushBack (_x getVariable ["ho_units_spawned",false]);
	_city_status pushBack (_x getVariable ["ieds",[]]);

	_cities_status pushBack _city_status;
	//diag_log format ["SAVE: %1 - %2",(_x getVariable "id"),(_x getVariable "occupied")];
} foreach btc_city_all;
profileNamespace setVariable ["btc_hm_cities",_cities_status];

//HIDEOUT
_array_ho = [];
{
	_data = [];
	_data pushBack (getPos _x);
	_data pushBack (_x getVariable ["id",0]);
	_data pushBack (_x getVariable ["rinf_time",0]);
	_data pushBack (_x getVariable ["cap_time",0]);
	_data pushBack (_x getVariable ["assigned_to",objNull]);
	
	_cache_markers = [];
	{
		_data = [];
		_data pushback (getMarkerPos _x);
		_data pushback (markerText _x);	
	} foreach (_x getVariable ["markers",[]]);
	_data pushback (_cache_markers);
	
	_array_ho pushBack _data;
} foreach btc_hideouts;
profileNamespace setVariable ["btc_hm_ho",_array_ho];

profileNamespace setVariable ["btc_hm_ho_sel",(btc_hq_red getVariable ["info_hideout",objNull])];

//CACHE
_array_cache = [];
_array_cache pushback (getposATL btc_cache_obj);
_array_cache pushback (btc_cache_n);
_array_cache pushback (btc_cache_info);
_cache_markers = [];
{
	_data = [];
	_data pushback (getMarkerPos _x);
	_data pushback (markerText _x);	
} foreach btc_cache_markers;
_array_cache pushback (_cache_markers);
profileNamespace setVariable ["btc_hm_cache",_array_cache];

//rep status
profileNamespace setVariable ["btc_hm_rep",btc_global_reputation];
//FOBS
_fobs = [];
{
	private "_pos";
	_pos = getMarkerPos _x;
	_fobs pushBack [_x,_pos];
} foreach btc_fobs;
profileNamespace setVariable ["btc_hm_fobs",_fobs];

//Vehicles status
_array_veh = [];
{
	_data = [];
	_data pushBack (typeOf _x);
	_data pushBack (getPos _x);
	_data pushBack (getDir _x);
	_data pushBack (fuel _x);
	_data pushBack (damage _x);
	_cargo = [];
	{_cargo pushBack (typeOf _x)} foreach (_x getVariable ["cargo",[]]);
	_data pushBack _cargo;
	_array_veh pushBack _data;
} foreach btc_vehicles;
profileNamespace setVariable ["btc_hm_vehs",_array_veh];

//Objects status
_array_obj = [];
{
	if (!isNil {_x getVariable "loaded"} || !Alive _x || isNull _x) exitWith {};
	_data = [];
	_data pushBack (typeOf _x);
	_data pushBack (getPosASL _x);
	_data pushBack (getDir _x);
	_array_obj pushBack _data;
} foreach btc_log_obj_created;
profileNamespace setVariable ["btc_hm_objs",_array_obj];

//
profileNamespace setVariable ["btc_hm_db",true];
saveProfileNamespace;
hint "saving...3";
[[9],"btc_fnc_show_hint"] spawn BIS_fnc_MP;

btc_db_is_saving = false;