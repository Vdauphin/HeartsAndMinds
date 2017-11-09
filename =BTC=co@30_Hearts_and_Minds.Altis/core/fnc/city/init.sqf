
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
		private ["_position","_name","_position","_radius_x","_radius_y","_new_position","_area"];
		_position = getarray(_current >> "position");
		if (surfaceIsWater _position) then {
			if !(_type isEqualTo "NameMarine") then {
				private _church = nearestTerrainObjects [_position, ["CHURCH"], 470];
				if (_church isEqualTo []) then {
					_area = 50;
					for "_i" from 0 to 3 do {
						_new_position = [_position, 0, _area, 0.5, 0, -1, 0] call BIS_fnc_findSafePos;
						if (count _new_position == 2) exitWith {_position = _new_position;};
						_area = _area * 2;
					};
				} else {
					_position = getPos (_church select 0);
				};
			};
		};
		_name = getText(_current >> "name");
		_radius_x = getNumber(_current >> "RadiusA");
		_radius_y = getNumber(_current >> "RadiusB");

		if (btc_city_blacklist find _name >= 0) exitWith {};

		/*
		//if you want a safe area
		if (_position distance getMarkerPos "YOUR_MARKER_AREA" < 500) exitWith {};
		*/

		[_position,_type,_name,_radius_x,_radius_y,random 1 > 0.45] call btc_fnc_city_create;
	};
};

if !(isNil "btc_custom_loc") then {
	{_x call btc_fnc_city_create} foreach btc_custom_loc;
};