
private ["_locations","_cities"];

_locations = configfile >> "cfgworlds" >> worldname >> "names";

_cities = ["NameVillage","NameCity","NameCityCapital","NameLocal","Hill"];
if (btc_p_sea) then {_cities pushBack "NameMarine";};
btc_city_all = [];
for "_i" from 0 to (count _locations - 1) do {
	private ["_current","_type"];
	_current = _locations select _i;

	_type = gettext(_current >> "type");
	if (_type in _cities) then {
		private ["_id","_city","_position","_name","_position","_radius_x","_radius_y","_has_en","_trigger"];
		_id = count btc_city_all;
		_position = getarray(_current >> "position");
		_name = getText(_current >> "name");
		_radius_x = getNumber(_current >> "RadiusA");
		_radius_y = getNumber(_current >> "RadiusB");

		if (btc_city_blacklist find _name >= 0) exitWith {};

	/*
		//if you want a safe area
		if (_position distance getMarkerPos "YOUR_MARKER_AREA" < 500) exitWith {};
	*/

		_city = "Land_Ammobox_rounds_F" createVehicle _position;
		_city hideObjectGlobal true;
		_city allowDamage false;
		_city enableSimulation false;
		_city setVariable ["activating",false];
		_city setVariable ["initialized",false];
		_city setVariable ["id",_id];
		_city setVariable ["name",_name];
		_city setVariable ["RadiusX",_radius_x];
		_city setVariable ["RadiusY",_radius_y];
		_city setVariable ["active",false];
		_city setVariable ["type",_type];
		_city setVariable ["spawn_more",false];
		_city setVariable ["data_units",[]];
		_has_en = (random 1 > 0.45);
		_city setVariable ["occupied",_has_en];
		if (btc_p_sea) then {
			_city setVariable ["hasbeach", (((selectBestPlaces [_position,0.8*(_radius_x+_radius_y), "sea",10,1]) select 0 select 1) isEqualTo 1)];
		};
		btc_city_all set [_id,_city];
		_trigger = createTrigger["EmptyDetector",getPos _city];
		_trigger setTriggerArea[(_radius_x+_radius_y) + btc_city_radius,(_radius_x+_radius_y) + btc_city_radius,0,false];
		_trigger setTriggerActivation[str(btc_player_side),"PRESENT",true];
		_trigger setTriggerStatements ["this && !btc_db_is_saving", format ["[%1] spawn btc_fnc_city_activate",_id], format ["[%1] spawn btc_fnc_city_de_activate",_id]];

		if (btc_debug) then	{//_debug
			private ["_marker"];
			_marker = createmarker [format ["loc_%1",_id],_position];
			_marker setMarkerShape "ELLIPSE";
			_marker setMarkerBrush "SolidBorder";
			_marker setMarkerSize [(_radius_x+_radius_y) + btc_city_radius, (_radius_x+_radius_y) + btc_city_radius];
			_marker setMarkerAlpha 0.3;
			//_marker setmarkertype "mil_dot";
			if (_has_en) then {_marker setmarkercolor "colorRed";} else {_marker setmarkercolor "colorGreen";};
			//_marker setmarkeralpha 0.5;
			_marke = createmarker [format ["locn_%1",_id],_position];
			_marke setmarkertype "mil_dot";
			_marke setmarkertext format ["loc_%3 %1 %2 - [%4] - [%5] ",_name,_type,_id,_has_en, _city getVariable ["hasbeach", "empty"] ];
		};
	};
};

if !(isNil "btc_custom_loc") then {
	{_x call btc_fnc_city_create} foreach btc_custom_loc;
};