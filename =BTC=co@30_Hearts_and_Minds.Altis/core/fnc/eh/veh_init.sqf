
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_veh_init

Description:
    Add custom ACE interaction depends one vehicle type (static weapon, land vehicle, helicopter and ship).

Parameters:
    _type - Type of vehicle to add custom ACE interaction. [String]

Returns:

Examples:
    (begin example)
        ["B_Truck_01_fuel_F"] call btc_fnc_eh_veh_init;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_type", "", [""]]
];

if (isNil "btc_actions_veh") then {btc_actions_veh = [];};
if ((btc_actions_veh pushBackUnique _type) isEqualTo -1) exitWith {};

switch true do {
    case (_type isKindOf "UGV_02_Base_F") : {};
    case (_type isKindOf "StaticWeapon") : {
        private _action = ["Logistic", localize "STR_BTC_HAM_ACTION_LOC_MAIN", "\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = ["log_tow", localize "STR_BTC_HAM_ACTION_VEHINIT_TOW", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_tow_ropeCreate;}, {!isNull btc_log_vehicle_selected && {btc_log_vehicle_selected != (_this select 0)} && {[_this select 0, btc_log_vehicle_selected] call btc_fnc_tow_check}}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = ["log_hook", localize "STR_BTC_HAM_ACTION_VEHINIT_HOOK", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_tow_hook;}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = ["log_hook", localize "STR_BTC_HAM_ACTION_VEHINIT_UHOOK", "\z\ace\addons\attach\UI\detach_ca.paa", {(_this select 0) spawn btc_fnc_tow_unhook;}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
    };
    case (_type isKindOf "LandVehicle") : {
        private _action = ["Logistic", localize "STR_BTC_HAM_ACTION_LOC_MAIN", "\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = ["log_tow", localize "STR_BTC_HAM_ACTION_VEHINIT_TOW", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_tow_ropeCreate;}, {!isNull btc_log_vehicle_selected && {btc_log_vehicle_selected != (_this select 0)} && {[_this select 0, btc_log_vehicle_selected] call btc_fnc_tow_check}}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = ["log_hook", localize "STR_BTC_HAM_ACTION_VEHINIT_HOOK", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_tow_hook;}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = ["log_hook", localize "STR_BTC_HAM_ACTION_VEHINIT_UHOOK", "\z\ace\addons\attach\UI\detach_ca.paa", {(_this select 0) spawn btc_fnc_tow_unhook;}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
    };
    case (_type isKindOf "Helicopter") : {
        private _action = ["Logistic", localize "STR_BTC_HAM_ACTION_LOC_MAIN", "\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
        //Lift
        _action = ["Deploy_ropes", localize "STR_ACE_Fastroping_Interaction_deployRopes", "\A3\ui_f\data\igui\cfg\simpleTasks\types\container_ca.paa", {[] spawn btc_fnc_lift_deployRopes;}, {!btc_ropes_deployed && {(driver vehicle player) isEqualTo player} && {(getPosATL player) select 2 > 4}}] call ace_interact_menu_fnc_createAction;
        [_type, 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
        _action = ["Cut_ropes", localize "STR_ACE_Fastroping_Interaction_cutRopes", "\z\ace\addons\logistics_wirecutter\ui\wirecutter_ca.paa", {[] spawn btc_fnc_lift_destroyRopes;}, {btc_ropes_deployed && {(driver vehicle player) isEqualTo player}}] call ace_interact_menu_fnc_createAction;
        [_type, 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
    };
    case (_type isKindOf "Ship") : {
        private _action = ["Logistic", localize "STR_BTC_HAM_ACTION_LOC_MAIN", "\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = ["log_tow", localize "STR_BTC_HAM_ACTION_VEHINIT_TOW", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_tow_ropeCreate;}, {!isNull btc_log_vehicle_selected && {btc_log_vehicle_selected != (_this select 0)} && {[_this select 0, btc_log_vehicle_selected] call btc_fnc_tow_check}}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = ["log_hook", localize "STR_BTC_HAM_ACTION_VEHINIT_HOOK", "\z\ace\addons\attach\UI\attach_ca.paa", {(_this select 0) spawn btc_fnc_tow_hook;}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = ["log_hook", localize "STR_BTC_HAM_ACTION_VEHINIT_UHOOK", "\z\ace\addons\attach\UI\detach_ca.paa", {(_this select 0) spawn btc_fnc_tow_unhook;}, {true}] call ace_interact_menu_fnc_createAction;
        [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
    };
};
