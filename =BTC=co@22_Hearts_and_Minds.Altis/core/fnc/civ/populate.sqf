
private ["_city","_area","_n","_pos","_houses"];

_city = _this select 0;
_area = _this select 1;
_n = _this select 2;

//_houses = [_city,_area] call btc_fnc_getHouses;

_pos = [];

switch (typeName _city) do {
	case "ARRAY" : {_pos = _city;};
	case "STRING": {_pos = getMarkerPos _city;};
	case "OBJECT": {_pos = position _city;};
};

_houses = [];

for [{_i = 25},{_i < _area},{_i = _i + 50}] do {
	private "_hs";
	_hs = [[(_pos select 0) + _i,(_pos select 1) + _i,0],50] call btc_fnc_getHouses;
	_houses = _houses + _hs;
	_hs = [[(_pos select 0) + _i,(_pos select 1) - _i,0],50] call btc_fnc_getHouses;
	_houses = _houses + _hs;
	_hs = [[(_pos select 0) - _i,(_pos select 1) - _i,0],50] call btc_fnc_getHouses;
	_houses = _houses + _hs;
	_hs = [[(_pos select 0) - _i,(_pos select 1) + _i,0],50] call btc_fnc_getHouses;
	_houses = _houses + _hs;
};


if (count _houses == 0) exitWith {};

for "_i" from 0 to _n do
{
	private ["_house","_unit_type"];
	if (count _houses == 0) exitWith {};
	_house = _houses select (floor random count _houses);
	
	_unit_type = btc_civ_type_units select (floor random count btc_civ_type_units);
	
	_group = createGroup civilian;
	_group createUnit [_unit_type, getPos _house, [], 0, "NONE"];
	_group spawn btc_fnc_civ_addWP;
	{_x call btc_fnc_civ_unit_create} foreach units _group;
	_houses = _houses - [_house];
};