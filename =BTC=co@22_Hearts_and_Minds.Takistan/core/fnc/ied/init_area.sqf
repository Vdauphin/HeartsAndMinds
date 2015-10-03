_city = _this select 0;
_area = _this select 1;
_n = _this select 2;

_pos = getPos _city;

_array = _city getVariable ["ieds",[]];

_active = true;

for "_i" from 1 to _n do
{
	private ["_sel_pos"];
	_sel_pos = _pos;
	_sel_pos = [_pos, _area] call btc_fnc_randomize_pos;
	_sel_pos = [_sel_pos, 30, 150, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;	

	_type_ied = btc_type_ieds select (floor random count btc_type_ieds);
	
	_dir = (random 360);

	if (random 1 > 0.3) then
	{
		private ["_roads","_obj"];
		_roads = _sel_pos nearRoads _area;
		if (count _roads > 0) then 
		{
			_obj = _roads select (floor random count _roads);
			if (random 1 > 0.5) then {_sel_pos = _obj modelToWorld [3.5,0,0];} else {_sel_pos = _obj modelToWorld [-3.5,0,0];};
		};
	}
	else
	{
		if (isOnRoad _sel_pos) then
		{
			private ["_roads","_obj","_dist"];
			_roads = _sel_pos nearRoads 15;
			if (count _roads > 0) then 
			{
				_obj = objNull;_dist = 100;
				{if (_x distance _sel_pos < _dist) then {_dist = _x distance _sel_pos;_obj = _x;};} foreach _roads;
				if (isNull _obj) exitWith {};
				if (random 1 > 0.5) then {_sel_pos = _obj modelToWorld [3.5,0,0];} else {_sel_pos = _obj modelToWorld [-3.5,0,0];};
			};
		}
	};


	if (btc_debug) then 
	{
		//Marker
		_marker = createmarker [format ["btc_ied_%1", _sel_pos], _sel_pos];
		format ["btc_ied_%1", _sel_pos] setmarkertypelocal "mil_warning";
		format ["btc_ied_%1", _sel_pos] setmarkercolorlocal "ColorRed";
		format ["btc_ied_%1", _sel_pos] setMarkerTextLocal "IED";//format ["ied %1", btc_hideouts_id];
		format ["btc_ied_%1", _sel_pos] setMarkerSizeLocal [0.8, 0.8];

	};

	if (btc_debug_log) then
	{
		diag_log format ["btc_fnc_ied_create_in_area: _this = %1 ; POS %2 ; N %3(%4)",_this,_sel_pos,_i,_n];
	};

	_array pushBack [_sel_pos,_type_ied,_dir,_active];
};

_active = false;

for "_i" from 1 to _n do
{
	private ["_sel_pos"];
	_sel_pos = _pos;
	_sel_pos = [_pos, _area] call btc_fnc_randomize_pos;
	_sel_pos = [_sel_pos, 30, 150, 1, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;	

	_type_ied = btc_type_ieds select (floor random count btc_type_ieds);
	
	_dir = (random 360);

	if (random 1 > 0.3) then
	{
		private ["_roads","_obj","_ied_pos"];
		_roads = _sel_pos nearRoads _area;
		if (count _roads > 0) then 
		{
			_obj = _roads select (floor random count _roads);
			if (random 1 > 0.5) then {_sel_pos = _obj modelToWorld [3,0,0];} else {_sel_pos = _obj modelToWorld [-3,0,0];};
		};
	};


	if (btc_debug) then 
	{
		//Marker
		_marker = createmarker [format ["btc_ied_%1", _sel_pos], _sel_pos];
		format ["btc_ied_%1", _sel_pos] setmarkertypelocal "mil_warning";
		format ["btc_ied_%1", _sel_pos] setmarkercolorlocal "ColorBlue";
		format ["btc_ied_%1", _sel_pos] setMarkerTextLocal "IED (fake)";//format ["ied %1", btc_hideouts_id];
		format ["btc_ied_%1", _sel_pos] setMarkerSizeLocal [0.8, 0.8];

	};

	if (btc_debug_log) then
	{
		diag_log format ["btc_fnc_ied_create_in_area: _this = %1 ; POS %2 ; N %3(%4)",_this,_sel_pos,_i,_n];
	};

	_array pushBack [_sel_pos,_type_ied,_dir,_active];
};

_city setVariable ["ieds",_array];
