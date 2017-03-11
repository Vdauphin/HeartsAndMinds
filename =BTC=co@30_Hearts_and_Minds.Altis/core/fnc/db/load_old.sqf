
private ["_name","_cities_status","_array_ho","_ho","_array_cache","_fobs","_fobs_loaded","_vehs","_objs"];

_name = worldName;

setDate (profileNamespace getVariable [format ["btc_hm_%1_date",_name],date]);

//CITIES
_cities_status = profileNamespace getVariable [format ["btc_hm_%1_cities",_name],[]];
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
_array_ho = profileNamespace getVariable [format ["btc_hm_%1_ho",_name],[]];

{
	private ["_pos","_hideout","_markers","_id","_city","_radius_x","_radius_y"];

	_pos = (_x select 0);
	_id = (_x select 4);
	_city = btc_city_all select _id;

	_hideout = [_pos] call btc_fnc_mil_create_hideout_composition;
	clearWeaponCargoGlobal _hideout;clearItemCargoGlobal _hideout;clearMagazineCargoGlobal _hideout;

	_city setpos _pos;
	if (btc_debug) then	{deleteMarker format ["loc_%1",_id];};
	deleteVehicle (_city getVariable ["trigger_player_side",objNull]);
	_radius_x = btc_hideouts_radius;
	_radius_y = btc_hideouts_radius;

	[_pos,_radius_x,_radius_y,_city,_city getVariable "occupied",_city getVariable "name",_city getVariable "type",_id] call btc_fnc_city_trigger_player_side;

	_city setVariable ["RadiusX",_radius_x];
	_city setVariable ["RadiusY",_radius_y];

	_hideout setVariable ["id",(_x select 1)];
	_hideout setVariable ["rinf_time",(_x select 2)];
	_hideout setVariable ["cap_time",(_x select 3)];
	_hideout setVariable ["assigned_to", _city];

	_hideout addEventHandler ["HandleDamage", btc_fnc_mil_hd_hideout];

	_markers = [];
	{
		private ["_marker"];
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
	btc_hideouts pushBack _hideout;
} foreach _array_ho;

_ho = profileNamespace getVariable [format ["btc_hm_%1_ho_sel",_name],0];
btc_hq setVariable ["info_hideout", btc_hideouts select _ho];

if (count btc_hideouts == 0) then {[] execVM "core\fnc\common\final_phase.sqf";};

//CACHE

btc_cache_cities = + btc_city_all;
btc_cache_markers = [];

_array_cache = profileNamespace getVariable [format ["btc_hm_%1_cache",_name],[]];

btc_cache_pos = _array_cache select 0;
btc_cache_n = _array_cache select 1;
btc_cache_info = _array_cache select 2;

call btc_fnc_cache_create;

{
	private ["_marker"];
	_marker = createmarker [format ["%1", (_x select 0)], (_x select 0)];
	_marker setmarkertype "hd_unknown";
	_marker setMarkerText (_x select 1);
	_marker setMarkerSize [0.5, 0.5];
	_marker setMarkerColor "ColorRed";
	btc_cache_markers pushBack _marker;
} foreach (_array_cache select 3);

//REP
btc_global_reputation = profileNamespace getVariable [format ["btc_hm_%1_rep",_name],0];

//FOB
_fobs = profileNamespace getVariable [format ["btc_hm_%1_fobs",_name],[]];
_fobs_loaded = [[],[]];

{
	private ["_pos","_fob_structure","_flag"];
	_pos = (_x select 1);
	createmarker [(_x select 0), _pos];
	(_x select 0) setMarkerSize [1,1];
	(_x select 0) setMarkerType "b_hq";
	(_x select 0) setMarkerText (_x select 0);
	(_x select 0) setMarkerColor "ColorBlue";
	(_x select 0) setMarkerShape "ICON";
	_fob_structure = createVehicle [btc_fob_structure, _pos, [], 0, "NONE"];
	_flag = createVehicle [btc_fob_flag, _pos, [], 0, "NONE"];
	_flag setVariable ["btc_fob",_x select 0];
	(_fobs_loaded select 0) pushBack (_x select 0);
	(_fobs_loaded select 1) pushBack _fob_structure;
} foreach (_fobs select 0);
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

_vehs = profileNamespace getVariable [format ["btc_hm_%1_vehs",_name],[]];
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
	private ["_veh","_cont","_weap","_mags","_items"];
	_veh = (_x select 0) createVehicle (_x select 1);
	_veh setPosASL (_x select 1);
	_veh setDir (_x select 2);
	if ((getPos _veh) select 2 < 0) then {_veh setVectorUp surfaceNormal position _veh;};
	_veh setFuel (_x select 3);
	_veh setDamage (_x select 4);
	_veh setVariable ["btc_dont_delete",true];
	_veh call btc_fnc_db_add_veh;
	{
		private ["_type","_cargo_obj","_obj","_weap_obj","_mags_obj","_items_obj"];
		//{_cargo pushBack [(typeOf _x),[getWeaponCargo _x,getMagazineCargo _x,getItemCargo _x]]} foreach (_x getVariable ["cargo",[]]);
		_type = _x select 0;
		_cargo_obj = _x select 2;
		_obj = _type createVehicle [0,0,0];
		if ((_x select 1) != "") then {_obj setVariable ["ace_rearm_magazineClass",(_x select 1),true]};
		btc_log_obj_created pushBack _obj;
		btc_curator addCuratorEditableObjects [[_obj], false];
		clearWeaponCargoGlobal _obj;clearItemCargoGlobal _obj;clearMagazineCargoGlobal _obj;
		_weap_obj = _cargo_obj select 0;
		if (count _weap_obj > 0) then {
			for "_i" from 0 to ((count (_weap_obj select 0)) - 1) do {
				_obj addWeaponCargoGlobal[((_weap_obj select 0) select _i),((_weap_obj select 1) select _i)];
			};
		};
		_mags_obj = _cargo_obj select 1;
		if (count _mags_obj > 0) then {
			for "_i" from 0 to ((count (_mags_obj select 0)) - 1) do {
				_obj addMagazineCargoGlobal[((_mags_obj select 0) select _i),((_mags_obj select 1) select _i)];
			};
		};
		_items_obj = _cargo_obj select 2;
		if (count _items_obj > 0) then {
			for "_i" from 0 to ((count (_items_obj select 0)) - 1) do {
				_obj addItemCargoGlobal[((_items_obj select 0) select _i),((_items_obj select 1) select _i)];
			};
		};
		[_obj,_veh] call btc_fnc_log_server_load;
	} foreach (_x select 5);
	_cont = (_x select 6);
	clearWeaponCargoGlobal _veh;clearItemCargoGlobal _veh;clearMagazineCargoGlobal _veh;
	_weap = _cont select 0;
	if (count _weap > 0) then {
		for "_i" from 0 to ((count (_weap select 0)) - 1) do {
			_veh addWeaponCargoGlobal[((_weap select 0) select _i),((_weap select 1) select _i)];
		};
	};
	_mags = _cont select 1;
	if (count _mags > 0) then {
		for "_i" from 0 to ((count (_mags select 0)) - 1) do {
			_veh addMagazineCargoGlobal[((_mags select 0) select _i),((_mags select 1) select _i)];
		};
	};
	_items = _cont select 2;
	if (count _items > 0) then {
		for "_i" from 0 to ((count (_items select 0)) - 1) do {
			_veh addItemCargoGlobal[((_items select 0) select _i),((_items select 1) select _i)];
		};
	};
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
_objs = profileNamespace getVariable [format ["btc_hm_%1_objs",_name],[]];
{
	private ["_obj","_cont","_weap","_mags","_items"];
	_obj = (_x select 0) createVehicle (_x select 1);
	btc_log_obj_created pushBack _obj;
	btc_curator addCuratorEditableObjects [[_obj], false];
	_obj setDir (_x select 2);
	_obj setPosASL (_x select 1);
	if ((_x select 3) != "") then {_obj setVariable ["ace_rearm_magazineClass",(_x select 3),true]};
	{
		/*private "_l";
		_l = _x createVehicle [0,0,0];
		btc_log_obj_created = btc_log_obj_created + [_l];
		btc_curator addCuratorEditableObjects [[_l], false];
		[_l,_obj] call btc_fnc_log_server_load;*/
		//NEW
		private ["_type","_cargo_obj","_l","_weap_obj","_mags_obj","_items_obj"];
		//{_cargo pushBack [(typeOf _x),[getWeaponCargo _x,getMagazineCargo _x,getItemCargo _x]]} foreach (_x getVariable ["cargo",[]]);
		_type = _x select 0;
		_cargo_obj = _x select 2;
		_l = _type createVehicle [0,0,0];
		if ((_x select 1) != "") then {_l setVariable ["ace_rearm_magazineClass",(_x select 1),true]};
		btc_log_obj_created  pushBack _l;
		btc_curator addCuratorEditableObjects [[_l], false];
		clearWeaponCargoGlobal _l;clearItemCargoGlobal _l;clearMagazineCargoGlobal _l;
		_weap_obj = _cargo_obj select 0;
		if (count _weap_obj > 0) then {
			for "_i" from 0 to ((count (_weap_obj select 0)) - 1) do {
				_l addWeaponCargoGlobal[((_weap_obj select 0) select _i),((_weap_obj select 1) select _i)];
			};
		};
		_mags_obj = _cargo_obj select 1;
		if (count _mags_obj > 0) then {
			for "_i" from 0 to ((count (_mags_obj select 0)) - 1) do {
				_l addMagazineCargoGlobal[((_mags_obj select 0) select _i),((_mags_obj select 1) select _i)];
			};
		};
		_items_obj = _cargo_obj select 2;
		if (count _items_obj > 0) then {
			for "_i" from 0 to ((count (_items_obj select 0)) - 1) do {
				_l addItemCargoGlobal[((_items_obj select 0) select _i),((_items_obj select 1) select _i)];
			};
		};
		[_l,_obj] call btc_fnc_log_server_load;
	} foreach (_x select 4);
	_cont = (_x select 5);
	clearWeaponCargoGlobal _obj;clearItemCargoGlobal _obj;clearMagazineCargoGlobal _obj;
	_weap = _cont select 0;
	if (count _weap > 0) then {
		for "_i" from 0 to ((count (_weap select 0)) - 1) do {
			_obj addWeaponCargoGlobal[((_weap select 0) select _i),((_weap select 1) select _i)];
		};
	};
	_mags = _cont select 1;
	if (count _mags > 0) then {
		for "_i" from 0 to ((count (_mags select 0)) - 1) do {
			_obj addMagazineCargoGlobal[((_mags select 0) select _i),((_mags select 1) select _i)];
		};
	};
	_items = _cont select 2;
	if (count _items > 0) then {
		for "_i" from 0 to ((count (_items select 0)) - 1) do {
			_obj addItemCargoGlobal[((_items select 0) select _i),((_items select 1) select _i)];
		};
	};
} foreach _objs;
