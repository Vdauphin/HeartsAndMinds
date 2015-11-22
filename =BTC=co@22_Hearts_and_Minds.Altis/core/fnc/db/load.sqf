
private ["_cities_status","_fobs","_fobs_loaded"];

setDate (profileNamespace getVariable ["btc_hm_date",date]);

//CITIES
_cities_status = profileNamespace getVariable ["btc_hm_cities",[]];
//diag_log format ["_cities_status: %1",_cities_status];

{
/*
	_city_status pushBack (_x getVariable "id");

	_city_status pushBack (_x getVariable "initialized");

	_city_status pushBack (_x getVariable "spawn_more");
	_city_status pushBack (_x getVariable "occupied");

	_city_status pushBack (_x getVariable "data_units");

	_city_status pushBack (_x getVariable ["has_ho",false]);
	_city_status pushBack (_x getVariable ["ho_units_spawned",false]);
	_city_status pushBack (_x getVariable ["ieds",[]]);
*/


	private ["_id","_city"];
	_id = _x select 0;
	_city = btc_city_all select _id;

	_city setVariable ["initialized",(_x select 1)];
	_city setVariable ["spawn_more",(_x select 2)];
	_city setVariable ["occupied",(_x select 3)];
	_city setVariable ["data_units",(_x select 4)];
	_city setVariable ["has_ho",(_x select 5)];
	_city setVariable ["ho_units_spawned",(_x select 6)];
	_city setVariable ["ieds",(_x select 7)];

	if (btc_debug) then	{//_debug

		if (_city getVariable ["occupied",false]) then {(_city getVariable ["marker",""]) setmarkercolor "colorRed";} else {(_city getVariable ["marker",""]) setmarkercolor "colorGreen";};
		(_city getVariable ["marker",""]) setmarkertext format ["loc_%3 %1 %2 - [%4]",(_city getVariable "name"),_city getVariable "type",_id,(_x select 3)];

		diag_log format ["ID: %1",_id];
		diag_log format ["data_city: %1",_x];
		diag_log format ["LOAD: %1 - %2",_id,(_x select 3)];
	};
} foreach _cities_status;

//HIDEOUT
/*
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
*/
_array_ho = profileNamespace getVariable ["btc_hm_ho",[]];

{
	_pos = (_x select 0);

	[_pos,(random 360),btc_composition_hideout] call btc_fnc_create_composition;

	_hideout = nearestObject [_pos, "C_supplyCrate_F"];
	clearWeaponCargoGlobal _hideout;clearItemCargoGlobal _hideout;clearMagazineCargoGlobal _hideout;
	_hideout setVariable ["id",(_x select 1)];
	_hideout setVariable ["rinf_time",(_x select 2)];
	_hideout setVariable ["cap_time",(_x select 3)];
	_hideout setVariable ["assigned_to",(_x select 4)];

	_hideout addEventHandler ["HandleDamage", btc_fnc_mil_hd_hideout];

	_markers = [];
	{
		_marker = createmarker [format ["%1", (_x select 0)], (_x select 0)];
		_marker setmarkertype "hd_warning";
		_marker setMarkerText (_x select 1);
		_marker setMarkerSize [0.5, 0.5];
		_marker setMarkerColor "ColorRed";
		_markers pushBack _marker;
	} foreach (_x select 5);

	_hideout setVariable ["markers",_markers];

	if (btc_debug) then {
		//Marker
		createmarker [format ["btc_hideout_%1", _pos], _pos];
		format ["btc_hideout_%1", _pos] setmarkertype "mil_unknown";
		format ["btc_hideout_%1", _pos] setMarkerText format ["Hideout %1", btc_hideouts_id];
		format ["btc_hideout_%1", _pos] setMarkerSize [0.8, 0.8];
	};

	if (btc_debug_log) then {diag_log format ["btc_fnc_mil_create_hideout: _this = %1 ; POS %2 ID %3",_x,_pos,btc_hideouts_id];};

	btc_hideouts_id = btc_hideouts_id + 1;
	btc_hideouts = btc_hideouts + [_hideout];
} foreach _array_ho;

_ho = profileNamespace getVariable ["btc_hm_ho_sel",objNull];
btc_hq setVariable ["info_hideout",_ho];

if (count btc_hideouts == 0) then {[] execVM "core\fnc\common\final_phase.sqf";};

//CACHE

btc_cache_cities = + btc_city_all;
btc_cache_markers = [];

_array_cache = profileNamespace getVariable ["btc_hm_cache",[]];

btc_cache_pos = _array_cache select 0;
btc_cache_n = _array_cache select 1;
btc_cache_info = _array_cache select 2;

btc_cache_obj = btc_cache_type createVehicle btc_cache_pos;
btc_cache_obj setPosATL (_array_cache select 0);
clearWeaponCargoGlobal btc_cache_obj;clearItemCargoGlobal btc_cache_obj;clearMagazineCargoGlobal btc_cache_obj;
btc_cache_obj addEventHandler ["HandleDamage", btc_fnc_cache_hd_cache];

{
	_marker = createmarker [format ["%1", (_x select 0)], (_x select 0)];
	_marker setmarkertype "hd_unknown";
	_marker setMarkerText (_x select 1);
	_marker setMarkerSize [0.5, 0.5];
	_marker setMarkerColor "ColorRed";
	btc_cache_markers = btc_cache_markers + [_marker];
} foreach (_array_cache select 3);

if (btc_debug_log) then {diag_log format ["CACHE SPAWNED: ID %1 POS %2",btc_cache_n,btc_cache_pos];};

if (btc_debug) then {
	player sideChat format ["Cache spawned in %1",btc_cache_pos];
	//Marker
	createmarker [format ["%1", btc_cache_pos], btc_cache_pos];
	format ["%1", btc_cache_pos] setmarkertype "mil_unknown";
	format ["%1", btc_cache_pos] setMarkerText format ["Cache %1", btc_cache_n];
	format ["%1", btc_cache_pos] setMarkerSize [0.8, 0.8];
};

//REP
btc_global_reputation = profileNamespace getVariable ["btc_hm_rep",0];

//FOB
_fobs = profileNamespace getVariable ["btc_hm_fobs",[]];
_fobs_loaded = [];

{
	private ["_pos"];
	_pos = (_x select 1);
	createmarker [(_x select 0), _pos];
	(_x select 0) setMarkerSize [1,1];
	(_x select 0) setMarkerType "hd_flag";
	(_x select 0) setMarkerText (_x select 0);
	(_x select 0) setMarkerColor "ColorBlue";
	(_x select 0) setMarkerShape "ICON";
	{createVehicle [_x, _pos, [], 0, "NONE"];} foreach [btc_fob_structure,btc_fob_flag];
	_fobs_loaded pushBack (_x select 0);
} foreach _fobs;

btc_fobs = _fobs_loaded;

//VEHICLES
/*	_data pushBack (typeOf _x);
	_data pushBack (getPos _x);
	_data pushBack (getDir _x);
	_data pushBack (fuel _x);
	_data pushBack (damage _x);
	_data pushBack (_x getVariable ["cargo",[]];);
*/

{deleteVehicle _x} foreach btc_vehicles;
btc_vehicles = [];

_vehs = profileNamespace getVariable ["btc_hm_vehs",[]];
/*
{diag_log format ["0: %1",(_x select 0)];
diag_log format ["1: %1",(_x select 1)];
diag_log format ["2: %1",(_x select 2)];
diag_log format ["3: %1",(_x select 3)];
diag_log format ["4: %1",(_x select 4)];
diag_log format ["5: %1",(_x select 5)];
{diag_log format ["5: %1",_x];} foreach (_x select 5)} foreach _vehs;
*/
{
	private "_veh";
	_veh = (_x select 0) createVehicle (_x select 1);
	btc_vehicles pushBack _veh;
	_veh addEventHandler ["Killed", {_this call btc_fnc_eh_veh_killed}];
	_veh setVariable ["btc_dont_delete",true];
	_veh setDir (_x select 2);
	_veh setFuel (_x select 3);
	_veh setDamage (_x select 4);
	{
		private "_obj";
		_obj = _x createVehicle [0,0,0];
		btc_log_obj_created = btc_log_obj_created + [_obj];
		[_obj,_veh] call btc_fnc_log_server_load;
	} foreach (_x select 5);
} foreach _vehs;

//Objs
/*
	if (!isNil {_x getVariable "loaded"}) exitWith {};
	_data = [];
	_data pushBack (typeOf _x);
	_data pushBack (getPosASL _x);
	_data pushBack (getDir _x);
	_cargo = [];
	{_cargo pushBack (typeOf _x)} foreach (_x getVariable ["cargo",[]]);
	_data pushBack _cargo;
	_array_obj pushBack _data;
	_array_obj pushBack _data;
*/
//btc_log_obj_created = [];
_objs = profileNamespace getVariable ["btc_hm_objs",[]];
{
	private "_obj";
	_obj = (_x select 0) createVehicle (_x select 1);
	btc_log_obj_created = btc_log_obj_created + [_obj];
	_obj setDir (_x select 2);
	_obj setPosASL (_x select 1);
	{
		private "_l";
		_l = _x createVehicle [0,0,0];
		btc_log_obj_created = btc_log_obj_created + [_l];
		[_l,_obj] call btc_fnc_log_server_load;
	} foreach (_x select 3);
} foreach _objs;
