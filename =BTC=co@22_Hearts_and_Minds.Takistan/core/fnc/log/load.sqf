
private ["_veh","_veh_name","_obj_name","_rc","_cc","_cargo","_rc_tot"];

_veh = _this;

_veh_name = getText (configFile >> "cfgVehicles" >> typeof _veh >> "displayName");
_obj_name = getText (configFile >> "cfgVehicles" >> typeof btc_log_object_selected >> "displayName");

if (btc_log_object_selected distance _veh > btc_log_max_distance_load) exitWith {hint format ["%1 is too far from %2!",_veh_name,_obj_name];};
if (speed _veh > 3) exitWith {hint format ["%1 is moving!",_veh_name];};


_rc = [btc_log_object_selected] call btc_fnc_log_get_rc;
_cc = [_veh] call btc_fnc_log_get_cc;

if (_rc > _cc) exitWith {hint format ["Can not load %1 in %2",_obj_name,_veh_name];};

btc_int_ask_data = nil;
[[3,_veh,player],"btc_fnc_int_ask_var",false] spawn BIS_fnc_MP;

waitUntil {!(isNil "btc_int_ask_data")};

_cargo = btc_int_ask_data;

_rc_tot = [_veh,_cargo] call btc_fnc_log_check_cc;

if ((_rc_tot + _rc) > _cc) exitWith {hint format ["There is no enough space for %1 in %2",_obj_name,_veh_name];};

[5,format ["Loading %1 in %2. . .",_obj_name,_veh_name],_veh] call btc_fnc_int_action_result;

waitUntil {!(isNil "btc_int_action_result")};

if (btc_int_action_result) then {
	//player setVariable ["btc_log_isDragging",false];
	[[btc_log_object_selected,_veh],"btc_fnc_log_server_load",false] spawn BIS_fnc_MP;
	hint format ["%1 has been loaded in %2",_obj_name,_veh_name];
} else {hint "Loading aborted";};
btc_log_object_selected = objNull;