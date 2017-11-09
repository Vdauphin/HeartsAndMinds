
private ["_veh","_veh_name","_obj_name","_rc","_cc","_cargo","_rc_tot"];

_veh = _this;

_veh_name = getText (configFile >> "cfgVehicles" >> typeof _veh >> "displayName");
_obj_name = getText (configFile >> "cfgVehicles" >> typeof btc_log_object_selected >> "displayName");
if (_obj_name isEqualTo "ace_rearm_dummy_obj") then {_obj_name = getText (configfile >> "CfgMagazines" >> (btc_log_object_selected getVariable "ace_rearm_magazineClass") >> "displayName");
};

if (btc_log_object_selected distance _veh > btc_log_max_distance_load) exitWith {hint format [(localize "STR_BTC_HAM_LOG_LOAD_TOOFAR"),_veh_name,_obj_name];}; //%1 is too far from %2!
if (speed _veh > 3) exitWith {hint format [(localize "STR_BTC_HAM_LOG_LOAD_TOOFAST"),_veh_name];}; //%1 is moving!


_rc = [btc_log_object_selected] call btc_fnc_log_get_rc;
_cc = [_veh] call btc_fnc_log_get_cc;

if (_rc > _cc) exitWith {hint format [(localize "STR_BTC_HAM_LOG_LOAD_TOOBIG"),_obj_name,_veh_name];}; //Can not load %1 in %2

btc_int_ask_data = nil;
[3,_veh,player] remoteExec ["btc_fnc_int_ask_var", 2];

waitUntil {!(isNil "btc_int_ask_data")};

_cargo = btc_int_ask_data;

_rc_tot = [_veh,_cargo] call btc_fnc_log_check_cc;

if ((_rc_tot + _rc) > _cc) exitWith {hint format [(localize "STR_BTC_HAM_LOG_LOAD_NOSPACE"),_obj_name,_veh_name];}; //There is no enough space for %1 in %2

[5,format [(localize "STR_BTC_HAM_LOG_LOAD_BAR"),_obj_name,_veh_name],_veh] call btc_fnc_int_action_result; //Loading %1 in %2. . .

waitUntil {!(isNil "btc_int_action_result")};

if (btc_int_action_result) then {
	//player setVariable ["btc_log_isDragging",false];
	[btc_log_object_selected,_veh] remoteExec ["btc_fnc_log_server_load", 2];
	hint format [(localize "STR_BTC_HAM_LOG_LOAD_FIN"),_obj_name,_veh_name]; //%1 has been loaded in %2
} else {hint (localize "STR_BTC_HAM_LOG_LOAD_ABORT");}; //Loading aborted
btc_log_object_selected = objNull;
