private ["_action"];

//Database
//_action = ["Database",(localize "STR_BTC_HAM_ACTION_DATA_MAIN"),"\A3\ui_f\data\igui\cfg\simpleTasks\letters\D_ca.paa",{},{serverCommandAvailable "#logout"}] call ace_interact_menu_fnc_createAction;
_action = ["Database",(localize "STR_BTC_HAM_ACTION_DATA_MAIN"),"\A3\ui_f\data\igui\cfg\simpleTasks\letters\D_ca.paa",{},{serverCommandAvailable "#logout" || !isMultiplayer}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["request_save",(localize "STR_BTC_HAM_ACTION_DATA_SAVE"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\download_ca.paa",{call btc_fnc_db_request_save;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Database"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["request_delete",(localize "STR_BTC_HAM_ACTION_DATA_DELETE"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa",{call btc_fnc_db_request_delete;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Database"], _action] call ace_interact_menu_fnc_addActionToObject;

//Intel
_action = ["Search_intel", (localize "STR_BTC_HAM_ACTION_INTEL_SEARCH"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {(_this select 0) spawn btc_fnc_info_search_for_intel;}, {!Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach (btc_type_units + btc_type_divers);
_action = ["Interrogate_intel", (localize "STR_BTC_HAM_ACTION_INTEL_INTERROGATE"), "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa", {[(_this select 0),true] spawn btc_fnc_info_ask;}, {(Alive (_this select 0) && {[(_this select 0)] call ace_common_fnc_isAwake} && captive (_this select 0))}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach (btc_type_units + btc_type_divers);

//Log point
_action = ["Logistic",(localize "STR_BTC_HAM_ACTION_LOC_MAIN"),"\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa",{},{true}] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Require_object", (localize "STR_BTC_HAM_ACTION_LOGPOINT_REQOBJ"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa", {[btc_create_object_point] spawn btc_fnc_log_create}, {true}, {}, [], [0,0,0.4], 5] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Repair_wreck", (localize "STR_BTC_HAM_ACTION_LOGPOINT_REPWRECK"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa", {[btc_create_object_point] spawn btc_fnc_log_repair_wreck}, {true}, {}, [], [0,0,0], 5] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Require_veh", (localize "STR_BTC_HAM_ACTION_LOGPOINT_REQVEH"), "\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa", {[btc_create_object_point] spawn btc_fnc_log_garage}, {(serverCommandAvailable "#logout" || !isMultiplayer) and btc_p_garage}, {}, [], [0,0,0], 5] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Tool",(localize "STR_BTC_HAM_ACTION_COPYPASTE_TOOL"),"\A3\ui_f\data\igui\cfg\simpleTasks\letters\T_ca.paa",{},{true}] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Copy", (localize "STR_BTC_HAM_ACTION_COPYPASTE_COPY"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\download_ca.paa", {[btc_create_object_point] spawn btc_fnc_log_copy}, {true}, {}, [], [0,0,0.4], 5] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions","Tool"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Paste", (localize "STR_BTC_HAM_ACTION_COPYPASTE_PASTE"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\upload_ca.paa", {[btc_copy_container, btc_create_object_point] call btc_fnc_log_paste}, {!isNil "btc_copy_container"}, {}, [], [0,0,0.4], 5] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions","Tool"], _action] call ace_interact_menu_fnc_addActionToObject;

//Logistic
_action = ["Logistic",(localize "STR_BTC_HAM_ACTION_LOC_MAIN"),"\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa",{},{true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_loadable;
_action = ["Load_in", (localize "STR_BTC_HAM_ACTION_LOGISTIC_LOADIN"), "a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa", {(_this select 0) call btc_fnc_log_select;}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_loadable;
_action = ["Load_selected", (localize "STR_BTC_HAM_ACTION_LOGISTIC_LOADSEL"), "a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa", {(_this select 0) spawn btc_fnc_log_load;}, {!isNull btc_log_object_selected && {btc_log_object_selected distance (_this select 0) <= btc_log_max_distance_load}}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_can_load;
_action = ["check_cargo", (localize "STR_BTC_HAM_ACTION_LOGISTIC_CHECKCARGO"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {(_this select 0) spawn btc_fnc_log_check_cargo;}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_can_load;

//FOB
_action = ["Mount_FOB", (localize "STR_BTC_HAM_ACTION_FOB_MOUNT"), "\A3\Ui_f\data\Map\Markers\NATO\b_hq.paa", {(_this select 0) spawn btc_fnc_fob_create}, {true}] call ace_interact_menu_fnc_createAction;
[btc_fob_mat, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
_action = ["Dismantle_FOB", (localize "STR_BTC_HAM_ACTION_FOB_DISMANTLE"), "", {(_this select 0) spawn btc_fnc_fob_dismantle}, {true},{},[], [0,0,-2], 5] call ace_interact_menu_fnc_createAction;
[btc_fob_flag, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
_action = ["Place", (localize "STR_BTC_HAM_ACTION_FOB_PLACE"), "\A3\ui_f\data\map\markers\military\end_CA.paa", {(_this select 0) spawn btc_fnc_log_place}, {!btc_log_placing}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_placeable;

//Orders
_action = ["Civil_Orders",(localize "STR_BTC_HAM_ACTION_ORDERS_MAIN"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa",{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Civil_Stop",(localize "STR_BTC_HAM_ACTION_ORDERS_STOP"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa",{[1] call btc_fnc_int_orders;},{(vehicle player isEqualTo player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Civil_Get_down",(localize "STR_BTC_HAM_ACTION_ORDERS_GETDOWN"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa",{[2] call btc_fnc_int_orders;},{(vehicle player isEqualTo player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Civil_Go_away",(localize "STR_BTC_HAM_ACTION_ORDERS_GOAWAY"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa",{[3] call btc_fnc_int_orders;},{(vehicle player isEqualTo player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Civil_Orders",(localize "STR_BTC_HAM_ACTION_ORDERS_MAIN"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa",{},{true}] call ace_interact_menu_fnc_createAction;
["Civilian", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
_action = ["Civil_Stop", (localize "STR_BTC_HAM_ACTION_ORDERS_STOP"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", {[1,(_this select 0)] call btc_fnc_int_orders;}, {Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
["Civilian", 0, ["ACE_MainActions","Civil_Orders"], _action, true] call ace_interact_menu_fnc_addActionToClass;
_action = ["Civil_Get_down", (localize "STR_BTC_HAM_ACTION_ORDERS_GETDOWN"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", {[2,(_this select 0)] call btc_fnc_int_orders;}, {Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
["Civilian", 0, ["ACE_MainActions","Civil_Orders"], _action, true] call ace_interact_menu_fnc_addActionToClass;
_action = ["Civil_taxi", (localize "STR_BTC_HAM_ACTION_ORDERS_TAXI"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", {[4,(_this select 0)] spawn btc_fnc_int_orders;}, {((Alive (_this select 0)) && !((vehicle (_this select 0)) isEqualTo (_this select 0)))}] call ace_interact_menu_fnc_createAction;
["Civilian", 0, ["ACE_MainActions","Civil_Orders"], _action, true] call ace_interact_menu_fnc_addActionToClass;
_action = ["Civil_Go_away", (localize "STR_BTC_HAM_ACTION_ORDERS_GOAWAY"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", {[3,(_this select 0)] call btc_fnc_int_orders;}, {Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
["Civilian", 0, ["ACE_MainActions","Civil_Orders"], _action, true] call ace_interact_menu_fnc_addActionToClass;
_action = ["Ask_Info", (localize "STR_BTC_HAM_ACTION_ORDERS_ASKINFO"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", {[(_this select 0),false] spawn btc_fnc_info_ask;}, {Alive (_this select 0) && {[(_this select 0)] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}}] call ace_interact_menu_fnc_createAction;
["Civilian", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
_action = ["Ask_Reputation", (localize "STR_BTC_HAM_ACTION_ORDERS_ASKREP"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", {[(_this select 0)] spawn btc_fnc_info_ask_reputation;}, {Alive (_this select 0) && {[(_this select 0)] call ace_common_fnc_isAwake} && {side (_this select 0) isEqualTo civilian}}] call ace_interact_menu_fnc_createAction;
["Civilian", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

//Side missions
_action = ["side_mission",(localize "STR_BTC_HAM_ACTION_SIDEMISSION_MAIN"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa",{},{!(isNil {player getVariable "side_mission"})}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["side_mission_abort",(localize "STR_BTC_HAM_ACTION_SIDEMISSION_ABORT"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa",{[] call btc_fnc_side_abort},{!(isNil {player getVariable "side_mission"}) && {btc_side_assigned}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "side_mission"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["side_mission_request",(localize "STR_BTC_HAM_ACTION_SIDEMISSION_REQ"),"\A3\ui_f\data\igui\cfg\simpleTasks\types\default_ca.paa",{[] spawn btc_fnc_side_request},{!(isNil {player getVariable "side_mission"}) && {!btc_side_assigned}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "side_mission"], _action] call ace_interact_menu_fnc_addActionToObject;

//Re-deploy
_action = ["fob_redeploy", (localize "STR_BTC_HAM_ACTION_REDEPLOY_MAIN"), "\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa", {[] spawn btc_fnc_fob_redeploy}, {btc_p_redeploy}, {}, [], [0.4,0,0.4], 5] call ace_interact_menu_fnc_createAction;
[btc_gear_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

//Arsenal
btc_gear_object addAction [(localize "STR_BTC_HAM_ACTION_ARSENAL_OPEN_NOACE"), "['Open',true] spawn BIS_fnc_arsenal;"];
