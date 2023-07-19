// #### Define Duststorm Function
cvo_ss_fnc_sandstorm 			= compileScript	["cvo\sandstorm\cvo_ss_fnc_sandstorm.sqf", 			false, ""];

cvo_ss_fnc_getAvgASL 			= compileScript	["cvo\sandstorm\cvo_ss_fnc_getAvgASL.sqf", 			false, ""];
cvo_ss_fnc_setFogFlexible 		= compileScript ["cvo\sandstorm\cvo_ss_fnc_setFogFlexible.sqf", 	false, ""];

cvo_ss_fnc_debug	 			= compileScript	["cvo\sandstorm\cvo_ss_fnc_debug.sqf",	 			false, ""];


cvo_ss_fnc_scheduler 			= compileScript	["cvo\sandstorm\cvo_ss_fnc_scheduler.sqf", 			false, ""];


// #### Start the Sandstorm Scheduler
// [] spawn cvo_ss_fnc_scheduler;




// #### Adds Zeus Interaction to start Sandstorm Script
// #### Start a Storm Manually

cvo_ss_phase = 0;
cvo_ss_remaining = 0;

// # NODE

_action = ["cvo_ss_zeus_node","CVO SANDSTORM","\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa",{},{isNil "cvo_ss_running" || {!cvo_ss_running} }] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _action] call ace_interact_menu_fnc_addActionToZeus;

// # 15
_statement = {
	[15] remoteExec ["cvo_ss_fnc_sandstorm",2]
	};
_action = [
	"cvo_ss_15","Start for 15 Minutes",
	"\A3\ui_f\data\igui\cfg\simpleTasks\types\move1_ca.paa",
	_statement,
	{isNil "cvo_ss_running" || {!cvo_ss_running} }
] call ace_interact_menu_fnc_createAction;

[
	["ACE_ZeusActions","cvo_ss_zeus_node"],
	_action
] call ace_interact_menu_fnc_addActionToZeus;


// # 30
_statement = {[30] remoteExec ["cvo_ss_fnc_sandstorm",2]};
_action = ["cvo_ss_30","Start for 30 Minutes","\A3\ui_f\data\igui\cfg\simpleTasks\types\move2_ca.paa",	_statement,{isNil "cvo_ss_running" || {!cvo_ss_running} }] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions","cvo_ss_zeus_node"], _action] call ace_interact_menu_fnc_addActionToZeus;

// # 45
_statement = {[45] remoteExec ["cvo_ss_fnc_sandstorm",2]};
_action = ["cvo_ss_45","Start for 45 Minutes","\A3\ui_f\data\igui\cfg\simpleTasks\types\move3_ca.paa",	_statement,{isNil "cvo_ss_running" || {!cvo_ss_running} }] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions","cvo_ss_zeus_node"], _action] call ace_interact_menu_fnc_addActionToZeus;

// # 60
_statement = {[60] remoteExec ["cvo_ss_fnc_sandstorm",2]};
_action = ["cvo_ss_60","Start for 60 Minutes","\A3\ui_f\data\igui\cfg\simpleTasks\types\move4_ca.paa",	_statement,{isNil "cvo_ss_running" || {!cvo_ss_running} }] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions","cvo_ss_zeus_node"], _action] call ace_interact_menu_fnc_addActionToZeus;




// #### INFO and Abort during an active Storm
// # Node
_action = ["cvo_ss_zeus_node_state","CVO Storm Active","\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa",{""},{!isNil "cvo_ss_running" && {cvo_ss_running isEqualTo true}}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _action] call ace_interact_menu_fnc_addActionToZeus;


// # Toggle Debug

_action = ["cvo_ss_zeus_toggleDebug","Toggle Debug","\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa",{[] call cvo_ss_fnc_debug;},{true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions","cvo_ss_zeus_node_state"], _action] call ace_interact_menu_fnc_addActionToZeus;


// # Cancel
_code = {
	[{
		[
			"Stopping Sandstorm - Press ESC to cancel",						// Title of progressBar
			10,																// Duration of progressBar in secounds
			{true},															// Condition, will check every frame
			{
				cvo_ss_running = false; publicVariable "cvo_ss_running";		// The actual fucking code
				diag_log format ["[CVO] [SandStorm] (ZeusMenu) - Early Exit by %1",name player ];

			}																// codeblock to be executed on completion
		] call CBA_fnc_progressBar;											// Executing a CBA progressBar from an Ace Interaction results in crash. Delay execution by 1 frame!!!
	}] call CBA_fnc_execNextFrame;											// <- this will delay the execution by 1 Frame. 
};
_action = ["cvo_ss_zeus_node_state_EXIT","Exit Sandstorm Early","\A3\ui_f\data\igui\cfg\simpleTasks\types\danger_ca.paa",_code,{true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions","cvo_ss_zeus_node_state"], _action] call ace_interact_menu_fnc_addActionToZeus;
