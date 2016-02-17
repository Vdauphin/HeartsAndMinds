
private ["_vehicle","_time","_has_marker","_type","_pos","_dir","_veh"];

_vehicle = _this select 0;
_time = _this select 1;
_has_marker = _this select 2;

_type = typeOf _vehicle;
_pos = getPos _vehicle;
_dir = getDir _vehicle;

_vehicle setVariable ["data_respawn",[_type,_pos,_dir,_time,_has_marker]];
_vehicle addMPEventHandler ["MPKilled", {if (isServer) then {_this call btc_fnc_eh_veh_respawn};}];
/*
waitUntil {sleep 10; (!Alive _vehicle)};

sleep _time;
deleteVehicle _vehicle;

_veh = _type createVehicle _pos;
_veh setDir _dir;
_veh setPos _pos;
if (_has_marker) then {_veh spawn btc_fnc_veh_track_marker;};*/