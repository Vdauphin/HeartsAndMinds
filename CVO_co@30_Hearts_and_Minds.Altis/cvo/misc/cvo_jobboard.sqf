
// ########## Setting up Cooldown
if (isNil "cvo_jobboard_cooldown") then {cvo_jobboard_cooldown = true; cvo_jobboard_cooldown_counter = 0;};

cvo_jb_fnc_cooldown = {
	cvo_jobboard_cooldown_counter = cvo_jobboard_cooldown_counter + 1;
	publicVariable "cvo_jobboard_cooldown_counter";
	if (cvo_jobboard_cooldown_counter > 2) then { 
		cvo_jobboard_cooldown = false;
		publicVariable "cvo_jobboard_cooldown";
		sleep 120;
		cvo_jobboard_cooldown = true;
		publicVariable "cvo_jobboard_cooldown";
	} else {
		cvo_jobboard_cooldown = false;
		publicVariable "cvo_jobboard_cooldown";
		sleep 5;
		cvo_jobboard_cooldown = true;
		publicVariable "cvo_jobboard_cooldown";
	};
};

_action = ["Cooldown","Cooldown","\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa",{""},{!cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;


// ########## Civilian AID

_action = ["CivilianAID","Civilian AID","\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa",{},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["civtreatment","Civil Medical Assistance","\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa",	{[false, "btc_side_fnc_civtreatment"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CivilianAID"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["mines","Clear Minefield","\A3\ui_f\data\igui\cfg\simpleTasks\types\mine_ca.paa",{[false, "btc_side_fnc_mines"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CivilianAID"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["supply","Support IDAP Humanitarian Efforts","\A3\ui_f\data\igui\cfg\simpleTasks\types\container_ca.paa",{[false, "btc_side_fnc_supply"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CivilianAID"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["vehicle","Roadside Assistance","\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",{[false, "btc_side_fnc_vehicle"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CivilianAID"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["removeRubbish","Remove Rubbish","\A3\ui_f\data\igui\cfg\simpleTasks\types\danger_ca.paa",{[false, "btc_side_fnc_removeRubbish"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CivilianAID"], _action] call ace_interact_menu_fnc_addActionToObject;


// ########### Combat Rescue

_action = ["CombatRescue","Combat Rescue","\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa",{},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["rescue","Pilot Mayday","\A3\ui_f\data\igui\cfg\simpleTasks\types\heli_ca.paa",{[false, "btc_side_fnc_rescue"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CombatRescue"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["hostage","Rescue Hostage","\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa",{[false, "btc_side_fnc_hostage"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CombatRescue"], _action] call ace_interact_menu_fnc_addActionToObject;


// ########### Assault

_action = ["Assault","Assault","\A3\ui_f\data\igui\cfg\simpleTasks\types\attack_ca.paa",{},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["get_city","Liberate Settlement","\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa",{[false, "btc_side_fnc_get_city"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","Assault"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["checkpoint","Checkpoint","\A3\ui_f\data\igui\cfg\simpleTasks\types\attack_ca.paa",{[false, "btc_side_fnc_checkpoint"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","Assault"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Tower","Destroy Tower","\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa",{[false, "btc_side_fnc_tower"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","Assault"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Kill","Assasination","\A3\ui_f\data\igui\cfg\simpleTasks\types\kill_ca.paa",{[false, "btc_side_fnc_kill"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","Assault"], _action] call ace_interact_menu_fnc_addActionToObject;




// ########### CBRN/EW

_action = ["CBRNEW","CBRN / EW","\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa",{},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;


_action = ["chemical_leak","Chemical Leak","\A3\ui_f\data\igui\cfg\simpleTasks\types\container_ca.paa",{[false, "btc_side_fnc_chemicalLeak"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CBRNEW"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["emp","EMP","\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa",{[false, "btc_side_fnc_emp"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CBRNEW"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Hack","Hack Missle","\A3\ui_f\data\igui\cfg\simpleTasks\types\upload_ca.paa",{[false, "btc_side_fnc_hack"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","CBRNEW"], _action] call ace_interact_menu_fnc_addActionToObject;


// ########### Ambush Convoy

_action = ["AmbushConvoy","Ambush Convoy","\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",{},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["convoy","Convoy","\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",{[false, "btc_side_fnc_convoy"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","AmbushConvoy"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["captureOfficer","Capture Officer","\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",{[false, "btc_side_fnc_capture_officier"] remoteExec ["btc_side_fnc_create", 2];	[] spawn cvo_jb_fnc_cooldown;	},{cvo_jobboard_cooldown}] call ace_interact_menu_fnc_createAction;
[cvo_jobboard, 0, ["ACE_MainActions","AmbushConvoy"], _action] call ace_interact_menu_fnc_addActionToObject;




// Adds Rubbish Removal Mission Request on the engineering Vehicle

_action = ["removeRubbish","Remove Rubbish","\A3\ui_f\data\igui\cfg\simpleTasks\types\danger_ca.paa",{[false, "btc_side_fnc_removeRubbish"] remoteExec ["btc_side_fnc_create", 2];},{true}] call ace_interact_menu_fnc_createAction;
[cvo_engineerVehicleClass, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
