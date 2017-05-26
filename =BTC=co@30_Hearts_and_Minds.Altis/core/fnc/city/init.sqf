
private ["_locations","_cities"];

_locations = configfile >> "cfgworlds" >> worldname >> "names";

_cities = ["NameVillage","NameCity","NameCityCapital","NameLocal","Hill","Airport"];
if (btc_p_sea) then {_cities pushBack "NameMarine";};
btc_city_all = [];
for "_i" from 0 to (count _locations - 1) do {
	private ["_current","_type"];
	_current = _locations select _i;

	_type = gettext(_current >> "type");
	if (_type in _cities) then {
		private ["_id","_city","_position","_name","_position","_radius_x","_radius_y","_has_en","_trigger","_new_position","_area"];
		_id = count btc_city_all;
		_position = getarray(_current >> "position");
		if (surfaceIsWater _position) then {
			if !(_type isEqualTo "NameMarine") then {
				_area = 50;
				for "_i" from 0 to 3 do {
					_new_position = [_position, 0, _area, 0.5, 0, -1, 0] call BIS_fnc_findSafePos;
					if (count _new_position == 2) exitWith {_position = _new_position;};
					_area = _area * 2;
				};
			};
		};
		_name = getText(_current >> "name");
		_radius_x = getNumber(_current >> "RadiusA");
		_radius_y = getNumber(_current >> "RadiusB");

		if (btc_city_blacklist find _name >= 0) exitWith {};


		//if you want a safe area
		if (_position distance getMarkerPos "btc_base" < 500) exitWith {};


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
		[_position,_radius_x,_radius_y,_city,_has_en,_name,_type,_id] call btc_fnc_city_trigger_player_side;
	};
};

if !(isNil "btc_custom_loc") then {
	{_x call btc_fnc_city_create} foreach btc_custom_loc;
};
