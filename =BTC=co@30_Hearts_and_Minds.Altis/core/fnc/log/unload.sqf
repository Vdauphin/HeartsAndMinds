
private ["_obj_name","_obj_type","_veh","_ctrlProgressBar","_ctrlProgressBarTitle","_time"];

if (!Dialog) exitWith {};

_obj_type = lbData [991, lbCurSel 991];

_veh = btc_log_veh_selected;

closeDialog 0;

_obj_name = getText (configFile >> "cfgVehicles" >> _obj_type >> "displayName");
if (_obj_name isEqualTo "ace_rearm_dummy_obj") then {_obj_name = "Ammo";};

if (vehicle player != player && {_veh isKindOf "Air"}) then {
	[[5,1] select (((getPos _veh) select 2) > 5),format [(localize "STR_BTC_HAM_LOG_UNLOAD_BAR"),_obj_name],_veh,99999] call btc_fnc_int_action_result; //Unloading %1. . .
} else {
	[5,format [(localize "STR_BTC_HAM_LOG_UNLOAD_BAR"),_obj_name],_veh] call btc_fnc_int_action_result; //Unloading %1. . .
};

waitUntil {!(isNil "btc_int_action_result")};

if (btc_int_action_result) then {
	[_obj_type,_veh] remoteExec ["btc_fnc_log_server_unload", 2];
	hint format [(localize "STR_BTC_HAM_LOG_UNLOAD_FIN"),_obj_name,getText (configFile >> "cfgVehicles" >> typeOf _veh >> "displayName")]; //%1 has been unloaded from %2
} else {hint (localize "STR_BTC_HAM_LOG_UNLOAD_ABORT");}; //Unloading aborted
