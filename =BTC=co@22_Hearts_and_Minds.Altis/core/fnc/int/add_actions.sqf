

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
_action = ["Disarm_IED", "Disarm IED", "", {(_this select 0) spawn btc_fnc_ied_disarm;}, {((_this select 0) getVariable ["active",false] && {"ACE_DefusalKit" in items player})}] call ace_interact_menu_fnc_createAction;
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

//Tow Hook
waituntil{!isNil {btc_type_motorized}}; // wait for define.sqf  === Vdauphin
_action1 = ["iniHook", "Hook", "", {btc_int_target = (_this select 0); btc_int_target spawn btc_fnc_log_hook;}, {(isNull ((_this select 0) getVariable ["tow",objNull]))}] call ace_interact_menu_fnc_createAction;
_action2 = ["iniTow", "Tow", "", {btc_int_target = (_this select 0); btc_int_target spawn btc_fnc_log_tow;}, 
{
(isNull ((_this select 0) getVariable ["tow",objNull]) && (!isNull btc_log_vehicle_selected && {btc_log_vehicle_selected != (_this select 0)}) && ([(_this select 0),btc_log_vehicle_selected] call btc_fnc_log_can_tow))
}] call ace_interact_menu_fnc_createAction;
_action3 = ["iniunhook", "Unhook", "", {btc_int_target = (_this select 0); btc_int_target spawn btc_fnc_log_unhook;}, {(!isNull ((_this select 0) getVariable ["tow",objNull]))}] call ace_interact_menu_fnc_createAction;

{
if (!(_x iskindof "Air")) then 
	{
		[_x, 0, ["ACE_MainActions"], _action1] call ace_interact_menu_fnc_addActionToClass;
		[_x, 0, ["ACE_MainActions"], _action2] call ace_interact_menu_fnc_addActionToClass;
		[_x, 0, ["ACE_MainActions"], _action3] call ace_interact_menu_fnc_addActionToClass;
	};
} foreach btc_type_motorized;
{
if (!(_x iskindof "Air")) then 	
	{
		[_x, 0, ["ACE_MainActions"], _action1] call ace_interact_menu_fnc_addActionToClass;
		[_x, 0, ["ACE_MainActions"], _action2] call ace_interact_menu_fnc_addActionToClass;
		[_x, 0, ["ACE_MainActions"], _action3] call ace_interact_menu_fnc_addActionToClass;
	};
} foreach btc_civ_type_veh;
_array = [];
{
_y=typeof _x;
if (!(_y iskindof "Air") && !(_y in _array)) then 
	{
		_array = _array + [_y];
		[_y, 0, ["ACE_MainActions"], _action1] call ace_interact_menu_fnc_addActionToClass;
		[_y, 0, ["ACE_MainActions"], _action2] call ace_interact_menu_fnc_addActionToClass;
		[_y, 0, ["ACE_MainActions"], _action3] call ace_interact_menu_fnc_addActionToClass;
	};
} foreach btc_player_motorized;

//Flag Teleport
_action = ["Teleport", "Teleport", "", {[] spawn btc_fnc_fob_redeploy;}, {true}] call ace_interact_menu_fnc_createAction;
[btc_fob_flag, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
// Mount FOB
_action = ["Mount_FOB", "Mount FOB", "", {btc_int_target = (_this select 0); btc_int_target spawn btc_fnc_fob_create;}, { ((_this select 0) distance (getMarkerPos "btc_base") > 1000)}] call ace_interact_menu_fnc_createAction;
[btc_fob_mat, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

