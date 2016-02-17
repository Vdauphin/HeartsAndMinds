
private ["_vehicle","_data"];

_vehicle = _this select 0;
_data = _vehicle getVariable ["data_respawn",[]];

_vehicle spawn {sleep 30;deleteVehicle _this;};

_data spawn {
	private ["_veh"];
	_time = (_this select 3);
	sleep _time;
	_veh = (_this select 0) createVehicle (_this select 1);
	_veh setDir (_this select 2);
	_veh setPos (_this select 1);
	[_veh,_time,(_this select 4)] spawn btc_fnc_eh_veh_add_respawn;
	if (_this select 4) then {_veh spawn btc_fnc_veh_track_marker;};
};
