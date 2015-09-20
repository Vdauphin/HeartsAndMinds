

_action = ["Arsenal", "Arsenal", "", {["Open",true] call BIS_fnc_arsenal;}, {true}, {}, [], [0,0,0.4], 5] call ace_interact_menu_fnc_createAction;
[btc_gear_object, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;

//Orders
_action = ["Civil_Orders","Civil Orders","",{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Civil_Stop","Stop","",{[1] call btc_fnc_int_orders;},{(vehicle player isEqualTo player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Civil_Get_down","Get down","",{[2] call btc_fnc_int_orders;},{(vehicle player isEqualTo player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Civil_Go_away","Go away","",{[3] call btc_fnc_int_orders;},{(vehicle player isEqualTo player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Civil_Orders","Civil Orders","",{},{true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_civ_type_units;
_action = ["Civil_Stop", "Stop", "", {[1,(_this select 0)] call btc_fnc_int_orders;}, {Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_civ_type_units;
_action = ["Civil_Get_down", "Get down", "", {[2,(_this select 0)] call btc_fnc_int_orders;}, {Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_civ_type_units;
_action = ["Civil_Go_away", "Go away", "", {[3,(_this select 0)] call btc_fnc_int_orders;}, {Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_civ_type_units;
_action = ["Ask_Info", "Ask info", "", {[(_this select 0)] call btc_fnc_info_ask;}, {Alive (_this select 0) && {side (_this select 0) isEqualTo civilian}}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_civ_type_units;

//Intel
_action = ["Search_intel", "Search for intel", "", {(_this select 0) spawn btc_fnc_info_search_for_intel;}, {!Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_type_units;

//IEDs
_action = ["Check_IED", "Check for IED", "", {(_this select 0) spawn btc_fnc_ied_check_for;}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_type_ieds;		
_action = ["Disarm_IED", "Disarm IED", "", {(_this select 0) spawn btc_fnc_ied_disarm;}, {((_this select 0) getVariable ["active",false] && {"ToolKit" in items player})}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_type_ieds;		

//Log point
_action = ["Logistic","Logistic","",{},{true}] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Require_object", "Require object", "", {[btc_create_object_point] spawn btc_fnc_log_create}, {true}, {}, [], [0,0,0.4], 5] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Repair_wreck", "Repair wreck", "", {[btc_create_object_point] spawn btc_fnc_log_repair_wreck}, {true}, {}, [], [0,0,0], 5] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
//Re-deploy
_action = ["fob_redeploy", "Re-deploy", "", {[] spawn btc_fnc_fob_redeploy}, {true}, {}, [], [0.4,0,0.4], 5] call ace_interact_menu_fnc_createAction;
[btc_gear_object, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;

//Side mission
_action = ['SEN_DCG','Side','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ['Abort_side','Abort side mission','',{[] spawn btc_fnc_side_abort;},{(btc_side_assigned)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;	
_action = ['Request_side','Request side mission','',{[] spawn btc_fnc_side_request;},{(!(btc_side_assigned))}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;
