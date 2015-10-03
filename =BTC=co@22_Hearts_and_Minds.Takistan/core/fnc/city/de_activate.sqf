
private ["_city","_radius_x","_radius_y","_radius","_has_en","_trigger","_data_units"];

_city = btc_city_all select (_this select 0);

if !(_city getVariable ["active",false]) exitWith {};

waitUntil {!(_city getVariable ["activating",false])};

hint ("DE-Activate " + str(_this));

//Save all and delete
_radius_x = _city getVariable ["RadiusX",0];
_radius_y = _city getVariable ["RadiusY",0];
_radius = (_radius_x+_radius_y);

_has_en = _city getVariable ["occupied",false];

if (_has_en) then {
	_trigger = _city getVariable ["trigger",objNull];
	deleteVehicle _trigger;
	_city setVariable ["trigger",objNull];
};

_data_units = [];
{
	if (((leader _x) distance _city) < _radius && {side _x != btc_player_side} && {isNil {_x getVariable "no_cache"}}) then {
		private ["_data_group"];
		_data_group = _x call btc_fnc_data_get_group;
		_data_units set [count _data_units, _data_group];
		if (btc_debug_log) then {diag_log format ["data_units = %1",_data_units];};
	};
} foreach allGroups;

_city setVariable ["data_units",_data_units];


_city setVariable ["active",false];

if (!btc_hideout_cap_checking) then {[] spawn btc_fnc_mil_check_cap};

call btc_fnc_clean_up;