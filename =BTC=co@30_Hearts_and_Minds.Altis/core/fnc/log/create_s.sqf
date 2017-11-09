
private ["_obj","_pos","_vector"];

if (count _this > 1) then {
	_pos = _this select 1;
	_vector = surfaceNormal _pos;
} else {
	_pos = getPosASL btc_create_object_point;
	_vector = vectorUp btc_create_object_point;
};

if (getText (configFile >> "cfgVehicles" >> (_this select 0) >> "displayName") isEqualTo "") then {
	_obj = [btc_create_object_point,(_this select 0)] call ace_rearm_fnc_createDummy;
} else {
	_obj = (_this select 0) createVehicle [0,0,0];
};
_obj setVectorUp _vector;
_obj setPosASL _pos;

btc_log_obj_created pushBack _obj;
btc_curator addCuratorEditableObjects [[_obj], false];