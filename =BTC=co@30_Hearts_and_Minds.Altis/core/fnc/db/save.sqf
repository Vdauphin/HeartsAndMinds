if !(isClass(configFile >> "cfgPatches" >> "inidbi2")) exitWith {[[11, "saved"],"btc_fnc_show_hint"] spawn BIS_fnc_MP;};

"delete" call OO_fnc_inidbi;

private ["_cities_status","_fobs","_city_status","_array_ho","_data","_ho_markers","_array_cache","_array_veh","_cargo","_array_obj","_marker","_data_units"];

hint "saving...";
[[8],"btc_fnc_show_hint"] spawn BIS_fnc_MP;

btc_db_is_saving = true;

["write", ["mission_Param", "date", date]] call OO_fnc_inidbi;

for "_i" from 0 to (count btc_city_all - 1) do {
	private "_s";
	_s = [_i] spawn btc_fnc_city_de_activate;
	waitUntil {scriptDone _s};
};
hint "saving...2";
//City status
hint "saving City status";
_cities_status = [];
_nb_cities_data_units = [[],[]];
{
	//[151,false,false,true,false,false,[]]
	private ["_id"];
	_city_status = [];
	_id = (_x getVariable "id");
	_city_status pushBack _id ;
	(_nb_cities_data_units select 0) pushBack _id;
	//_city_status pushBack (_x getVariable "name");

	_city_status pushBack (_x getVariable "initialized");

	_city_status pushBack (_x getVariable "spawn_more");
	_city_status pushBack (_x getVariable "occupied");

	_data_units = +(_x getVariable "data_units");
	{
		if ((_x select 0) isEqualTo 3) then {
			_x set [7,getPos (_x select 7)];
		};
	} forEach _data_units;
	(_nb_cities_data_units select 1) pushBack ([_data_units,"cities",format ["city_%1_data_units",(_city_status select 0)]] call btc_fnc_db_save_array);

	_city_status pushBack (_x getVariable ["has_ho",false]);
	_city_status pushBack (_x getVariable ["ho_units_spawned",false]);
	_city_status pushBack (_x getVariable ["ieds",[]]);

	_cities_status pushBack _city_status;
	//diag_log format ["SAVE: %1 - %2",(_x getVariable "id"),(_x getVariable "occupied")];
} foreach btc_city_all;
["write", ["cities", "nb_cities_data_units", _nb_cities_data_units]] call OO_fnc_inidbi;

_nb_cities_status = [[_cities_status,"cities","cities_status"] call btc_fnc_db_save_array];
["write", ["cities", "nb_cities_status", _nb_cities_status]] call OO_fnc_inidbi;


//HIDEOUT
hint "saving HIDEOUT";
_array_ho = [];
{
	_data = [];
	_data pushBack (getPos _x);
	_data pushBack (_x getVariable ["id",0]);
	_data pushBack (_x getVariable ["rinf_time",0]);
	_data pushBack (_x getVariable ["cap_time",0]);

	_ho_markers = [];
	{
		_marker = [];
		_marker pushback (getMarkerPos _x);
		_marker pushback (markerText _x);
		_ho_markers pushback _marker;
	} foreach (_x getVariable ["markers",[]]);
	_data pushback (_ho_markers);
	diag_log format ["HO %1 DATA %2",_x,_data];
	_array_ho pushBack _data;
} foreach btc_hideouts;
["write", ["cities", "ho", _array_ho]] call OO_fnc_inidbi;

["write", ["cities", "ho_sel", (btc_hq getVariable ["info_hideout",objNull]) getVariable ["id",0] ]] call OO_fnc_inidbi;

//CACHE
hint "saving CACHE";
_array_cache = [];
_array_cache pushback (getposATL btc_cache_obj);
_array_cache pushback (btc_cache_n);
_array_cache pushback (btc_cache_info);
_cache_markers = [];
{
	_data = [];
	_data pushback (getMarkerPos _x);
	_data pushback (markerText _x);
	_cache_markers pushBack _data;
} foreach btc_cache_markers;
_array_cache pushback (_cache_markers);
["write", ["cities", "cache", _array_cache]] call OO_fnc_inidbi;

//rep status
["write", ["cities", "rep", btc_global_reputation]] call OO_fnc_inidbi;

//FOBS
_fobs = [[],[]];
{
	private "_pos";
	_pos = getMarkerPos _x;
	(_fobs select 0) pushBack [_x,_pos];
} foreach (btc_fobs select 0);
["write", ["base", "fobs", _fobs]] call OO_fnc_inidbi;

//Vehicles status
_array_veh = [];
{
	private ["_data","_cargo","_cont"];
	_data = [];
	_data pushBack (typeOf _x);

	_pos = getPos _x;
	_data pushBack ([_pos select 0, _pos select 1, [0,_pos select 2] select ((_pos select 1) < 0) ]);

	_data pushBack (getDir _x);
	_data pushBack (fuel _x);
	_data pushBack (damage _x);
	_cargo = [];
	{_cargo pushBack [(typeOf _x),(_x getVariable ["ace_rearm_magazineClass",""]),[getWeaponCargo _x,getMagazineCargo _x,getItemCargo _x]]} foreach (_x getVariable ["cargo",[]]);
	_data pushBack _cargo;
	_cont = [getWeaponCargo _x,getMagazineCargo _x,getItemCargo _x];
	_data pushBack _cont;
	_array_veh pushBack _data;
	//diag_log format ["VEH %1 DATA %2",_x,_data];
} foreach btc_vehicles;
["write", ["base", "vehs", _array_veh]] call OO_fnc_inidbi;

//Objects status
_array_obj = [];
{
	if !(!isNil {_x getVariable "loaded"} || !Alive _x || isNull _x) then {
		_data = [];
		_data pushBack (typeOf _x);
		_data pushBack (getPosASL _x);
		_data pushBack (getDir _x);
		_data pushBack (_x getVariable ["ace_rearm_magazineClass",""]);
		_cargo = [];
		{_cargo pushBack [(typeOf _x),(_x getVariable ["ace_rearm_magazineClass",""]),[getWeaponCargo _x,getMagazineCargo _x,getItemCargo _x]]} foreach (_x getVariable ["cargo",[]]);
		_data pushBack _cargo;
		_cont = [getWeaponCargo _x,getMagazineCargo _x,getItemCargo _x];
		_data pushBack _cont;

		_array_obj pushBack _data;
	};
} foreach btc_log_obj_created;
["write", ["base", "objs", _array_obj]] call OO_fnc_inidbi;

hint "saving...3";
[[9],"btc_fnc_show_hint"] spawn BIS_fnc_MP;

btc_db_is_saving = false;