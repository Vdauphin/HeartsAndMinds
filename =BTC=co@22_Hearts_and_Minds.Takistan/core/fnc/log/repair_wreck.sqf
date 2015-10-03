_object = _this select 0;
_array = nearestObjects [position _object, ["LandVehicle","Air"], 10];
	
if (count _array == 0) exitWith {hint "No wreck";};
	
if (damage (_array select 0) != 1) exitWith {hint "It is not a wreck!"};
	
[[(_array select 0)],"btc_fnc_log_server_repair_wreck",false] spawn BIS_fnc_MP;