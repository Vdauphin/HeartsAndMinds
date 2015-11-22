
if !(isServer) exitWith {[_this,"btc_fnc_db_add_veh",false] spawn BIS_fnc_MP;};

if !(_this in btc_vehicles) then {
	btc_vehicles pushBack _this;
	_this addEventHandler ["Killed", {_this call btc_fnc_eh_veh_killed}];
};