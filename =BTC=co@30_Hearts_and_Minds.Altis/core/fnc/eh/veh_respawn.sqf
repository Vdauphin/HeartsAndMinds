
private ["_vehicle","_data"];

_vehicle = _this select 0;
_data = _vehicle getVariable ["data_respawn",[]];

[_vehicle,_data] spawn {
	params ["_vehicle","_data"];
	private _time = (_data select 3);
	sleep _time;
	deleteVehicle _vehicle;
	sleep 1;
	private _veh = (_data select 0) createVehicle (_data select 1);
	_veh setDir (_data select 2);
	_veh setPosASL (_data select 1);
	[_veh,_time,(_data select 4)] spawn btc_fnc_eh_veh_add_respawn;
	if (_data select 4) then {_veh spawn btc_fnc_veh_track_marker;};
};
