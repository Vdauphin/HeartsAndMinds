
//Arsenal
_action = ["btc_arsenal", "Arsenal", "", {["Open",true] call BIS_fnc_arsenal;}, {true}] call ace_interact_menu_fnc_createAction;
[btc_gear_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

//Database
//_action = ["Database","Database","",{},{serverCommandAvailable "#logout"}] call ace_interact_menu_fnc_createAction;
_action = ["Database","Database","",{},{serverCommandAvailable "#logout" || !isMultiplayer}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["request_save","Save","",{call btc_fnc_db_request_save;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Database"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["request_delete","Delete","",{call btc_fnc_db_request_delete;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Database"], _action] call ace_interact_menu_fnc_addActionToObject;

//Intel
_action = ["Search_intel", "Search for intel", "", {(_this select 0) spawn btc_fnc_info_search_for_intel;}, {!Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_type_units;

//IEDs
_action = ["Check_IED", "Check for IED", "", {(_this select 0) spawn btc_fnc_ied_check_for;}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_type_ieds;		
_action = ["Disarm_IED", "Disarm IED", "", {(_this select 0) spawn btc_fnc_ied_disarm;}, {((_this select 0) getVariable ["active",false] && {"ACE_DefusalKit" in items player})}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_type_ieds;		

//Log point
_action = ["Logistic","Logistic","",{},{true}] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Require_object", "Require object", "", {[btc_create_object_point] spawn btc_fnc_log_create}, {true}, {}, [], [0,0,0.4], 5] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Repair_wreck", "Repair wreck", "", {[btc_create_object_point] spawn btc_fnc_log_repair_wreck}, {true}, {}, [], [0,0,0], 5] call ace_interact_menu_fnc_createAction;
[btc_create_object, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;

//Logistic
_action = ["Logistic","Logistic","",{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_loadable;
_action = ["Load_in", "Load in", "", {(_this select 0) call btc_fnc_log_select;}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_loadable;
_action = ["Load_selected", "Load selected", "", {(_this select 0) spawn btc_fnc_log_load;}, {!isNull btc_log_object_selected && {btc_log_object_selected distance (_this select 0) <= btc_log_max_distance_load}}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_can_load;
_action = ["check_cargo", "Check cargo", "", {(_this select 0) spawn btc_fnc_log_check_cargo;}, {true}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_can_load;
_action = ["Mount_FOB", "Mount FOB", "", {(_this select 0) spawn btc_fnc_fob_create}, {true}] call ace_interact_menu_fnc_createAction;
[btc_fob_mat, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
_action = ["Place", "Place", "", {(_this select 0) spawn btc_fnc_log_place;}, {!btc_log_placing}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_log_def_placeable;

_action = ["check_cargo","Check cargo","",{(vehicle player) spawn btc_fnc_log_check_cargo;},{!(vehicle player isEqualto player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Logistic"], _action] call ace_interact_menu_fnc_addActionToObject;

//Lift
_action = ["Lift","Lift","",{},{(typeOf vehicle player) isKindOf "Helicopter"}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Deploy_ropes","Deploy ropes","",{[] spawn btc_fnc_log_lift_deploy_ropes;},{!btc_ropes_deployed && {((driver vehicle player) isEqualTo player)} && {(getposATL player) select 2 > 4}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Lift"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["Cut_ropes","Cut ropes","",{[] spawn btc_fnc_log_lift_destroy_ropes;},{btc_ropes_deployed && {((driver vehicle player) isEqualTo player)}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","Lift"], _action] call ace_interact_menu_fnc_addActionToObject;

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
_action = ["Ask_Info", "Ask info", "", {[(_this select 0)] spawn btc_fnc_info_ask;}, {Alive (_this select 0) && {side (_this select 0) isEqualTo civilian}}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} foreach btc_civ_type_units;

//Re-deploy
_action = ["fob_redeploy", "Re-deploy", "", {[] spawn btc_fnc_fob_redeploy}, {btc_p_redeploy}, {}, [], [0.4,0,0.4], 5] call ace_interact_menu_fnc_createAction;
[btc_gear_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

//Side missions
_action = ["side_mission","Side mission","",{},{!(isNil {player getVariable "side_mission"})}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["side_mission","Abort","",{[] call btc_fnc_side_abort},{!(isNil {player getVariable "side_mission"}) && {btc_side_assigned}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "side_mission"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["side_mission","Request","",{[] spawn btc_fnc_side_request},{!(isNil {player getVariable "side_mission"}) && {!btc_side_assigned}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "side_mission"], _action] call ace_interact_menu_fnc_addActionToObject;