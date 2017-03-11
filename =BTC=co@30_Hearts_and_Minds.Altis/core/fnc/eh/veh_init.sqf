
private ["_veh","_type"];

_veh = _this select 0;

_type = typeOf _veh;
if (isNil "btc_actions_veh") then {btc_actions_veh = [];};
if ((btc_actions_veh pushBackUnique _type) isEqualTo -1) exitWith {};

switch true do {
	case (_type isKindOf "StaticWeapon"): 	{
		private ["_action"];
		_action = ["Logistic","Logistic","\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa",{},{true}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
		_action = ["log_tow", "Tow", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_log_tow;}, {!isNull btc_log_vehicle_selected && {btc_log_vehicle_selected != (_this select 0)} && {[(_this select 0),btc_log_vehicle_selected] call btc_fnc_log_can_tow}}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
		_action = ["log_hook", "Hook", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_log_hook;}, {true}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
		_action = ["log_hook", "Unhook", "\z\ace\addons\attach\UI\detach_ca.paa", {(_this select 0) spawn btc_fnc_log_unhook;}, {true}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
	};
	case (_type isKindOf "LandVehicle") : {
		private ["_action"];
		_action = ["Logistic","Logistic","\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa",{},{true}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
		_action = ["log_tow", "Tow", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_log_tow;}, {!isNull btc_log_vehicle_selected && {btc_log_vehicle_selected != (_this select 0)} && {[(_this select 0),btc_log_vehicle_selected] call btc_fnc_log_can_tow}}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
		_action = ["log_hook", "Hook", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_log_hook;}, {true}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
		_action = ["log_hook", "Unhook", "\z\ace\addons\attach\UI\detach_ca.paa", {(_this select 0) spawn btc_fnc_log_unhook;}, {true}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
		//Cargo
		_action = ["check_cargo", "Check Cargo", "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {(_this select 0) spawn btc_fnc_log_check_cargo;}, {true}] call ace_interact_menu_fnc_createAction;
		//Outside Vehicle
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
		//Inside Vehicle
		[_type, 1, ["ACE_SelfActions"], _action,true] call ace_interact_menu_fnc_addActionToClass;
		_action = ["Load_selected", "Load selected", "\z\ace\addons\cargo\UI\Icon_load.paa", {(_this select 0) spawn btc_fnc_log_load;}, {!isNull btc_log_object_selected && {btc_log_object_selected distance (_this select 0) <= btc_log_max_distance_load}}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
	};
	case (_type isKindOf "Helicopter") : {
		private ["_action"];
		_action = ["Logistic","Logistic","\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa",{},{true}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
		//Cargo
		_action = ["check_cargo", "Check Cargo", "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {(_this select 0) spawn btc_fnc_log_check_cargo;}, {true}] call ace_interact_menu_fnc_createAction;
		//Outside Vehicle
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
		//Inside Vehicle
		[_type, 1, ["ACE_SelfActions"], _action,true] call ace_interact_menu_fnc_addActionToClass;
		_action = ["Load_selected", "Load selected", "\z\ace\addons\cargo\UI\Icon_load.paa", {(_this select 0) spawn btc_fnc_log_load;}, {!isNull btc_log_object_selected && {btc_log_object_selected distance (_this select 0) <= btc_log_max_distance_load}}] call ace_interact_menu_fnc_createAction;
		[_type, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
		//Lift
		_action = ["Deploy_ropes","Deploy ropes","\A3\Structures_F_Heli\VR\Helpers\Data\VR_Symbol_Heli_Slingloading_CA.paa",{[] spawn btc_fnc_log_lift_deploy_ropes;},{!btc_ropes_deployed && {((driver vehicle player) isEqualTo player)} && {(getposATL player) select 2 > 4}}] call ace_interact_menu_fnc_createAction;
		[_type, 1, ["ACE_SelfActions"], _action,true] call ace_interact_menu_fnc_addActionToClass;
		_action = ["Cut_ropes","Cut ropes","\z\ace\addons\logistics_wirecutter\ui\wirecutter_ca.paa",{[] spawn btc_fnc_log_lift_destroy_ropes;},{btc_ropes_deployed && {((driver vehicle player) isEqualTo player)}}] call ace_interact_menu_fnc_createAction;
		[_type, 1, ["ACE_SelfActions"], _action,true] call ace_interact_menu_fnc_addActionToClass;
	};
	case (_type isKindOf "Ship") : {
		private ["_action"];
		//Lift
		_action = ["Deploy_ropes","Deploy ropes","\A3\Structures_F_Heli\VR\Helpers\Data\VR_Symbol_Heli_Slingloading_CA.paa",{[] spawn btc_fnc_log_lift_deploy_ropes;},{!btc_ropes_deployed && {((driver vehicle player) isEqualTo player)}}] call ace_interact_menu_fnc_createAction;
		[_type, 1, ["ACE_SelfActions"], _action,true] call ace_interact_menu_fnc_addActionToClass;
		_action = ["Cut_ropes","Cut ropes","\z\ace\addons\logistics_wirecutter\ui\wirecutter_ca.paa",{[] spawn btc_fnc_log_lift_destroy_ropes;},{btc_ropes_deployed && {((driver vehicle player) isEqualTo player)}}] call ace_interact_menu_fnc_createAction;
		[_type, 1, ["ACE_SelfActions"], _action,true] call ace_interact_menu_fnc_addActionToClass;
	};
};