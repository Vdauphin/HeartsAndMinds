
private "_veh";

(_this select 0) spawn {sleep 30;deleteVehicle _this;};

_veh = btc_helo_type createVehicle btc_helo_pos;
_veh setDir btc_helo_dir;
_veh setPos btc_helo_pos;
_veh spawn btc_fnc_veh_track_marker;