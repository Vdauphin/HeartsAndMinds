
private ["_obj_type","_veh","_ctrlProgressBar","_ctrlProgressBarTitle","_time"];

if (!Dialog) exitWith {};

_obj_type = lbData [991, lbCurSel 991];

_veh = btc_log_veh_selected;

closeDialog 0;

if (vehicle player != player && {_veh isKindOf "Air"}) then {
	[5,format ["Unloading %1. . .",getText (configFile >> "cfgVehicles" >> _obj_type >> "displayName")],_veh,99999] call btc_fnc_int_action_result;
} else {
	[5,format ["Unloading %1. . .",getText (configFile >> "cfgVehicles" >> _obj_type >> "displayName")],_veh] call btc_fnc_int_action_result;
};

waitUntil {!(isNil "btc_int_action_result")};

if (btc_int_action_result) then {
	[[_obj_type,_veh],"btc_fnc_log_server_unload",false] spawn BIS_fnc_MP;
	hint format ["%1 has been unloaded from %2",getText (configFile >> "cfgVehicles" >> _obj_type >> "displayName"),getText (configFile >> "cfgVehicles" >> typeOf _veh >> "displayName")];
} else {hint "Unloading aborted";};