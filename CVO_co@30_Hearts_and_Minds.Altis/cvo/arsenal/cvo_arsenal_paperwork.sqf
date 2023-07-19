/*
 * Author: Dr. Zorn 
 * Adds an Ace Interaction to an object so players can safe their respawn loadout with a progressbar (5s) on said object.
 * Dependency: ACE, CBA
 * 
 *
 */

// Here you define the code you want to execute, in this case, via a progress bar

if (count CVO_arsenal_paperwork isEqualTo 0) exitWith {};

////////////////////// SAVE RESPAWN LOADOUT
// Here we create the action to manually save the Loadout
_code = {
	[{
		[
			"Filling out Paperwork... (saving Respawn Loadout)",		// Title of progressBar
			5,								// Duration of progressBar in secounds
			{true},							// Condition, will check every frame
			{
				player setVariable ["CVO_Loadout", getUnitLoadout player];		// The actual fucking code
			}								// codeblock to be executed on completion
		] call CBA_fnc_progressBar;			// Executing a CBA progressBar from an Ace Interaction results in crash. Delay execution by 1 frame!!!
	}] call CBA_fnc_execNextFrame;			// <- this will delay the execution by 1 Frame. 
}; 											// This is the code you want the interaction to execute.


_cvo_saveLoadout = [
	"CVO_Arsenal_saveLoadout",				// Action Name
	"Fillout the Stupid Armory Paperwork (save Respawn Loadout)",								// Name for the ACE Interaction Menu
	"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",										// Statement - i have no fucking clue what that is supposed to mean
	_code,									// the coe you're executing
	{true}									// Condition
] call ace_interact_menu_fnc_createAction;


// Here we Attach the Action to the Object
{
	[
		_x,														// OBJECT the action should be assigned to
		0,														// Type of action, 0 for action, 1 for self-actionIDs
		["ACE_MainActions"],									// Parent path of the new action <Array>
		_cvo_saveLoadout
	] call ace_interact_menu_fnc_addActionToObject;				// Alternative: ace_interact_menu_fnc_addActionToObject 
} forEach CVO_arsenal_paperwork;



////////////////////// UPDATE ARSENAL


// Here we create the action to reload the Arsenals Virtual Items 
_code2 = {
	[{
		[
			"Asking the Quatermaster to doublecheck your allowance... (update Arsenal)",		// Title of progressBar
			5,								// Duration of progressBar in secounds
			{true},							// Condition, will check every frame
			{
				//// The actual fucking Code
				// Remove Arsenal
				{ [_x, true, false] call ace_arsenal_fnc_removeVirtualItems; } forEach CVO_arsenal_boxes;
				// Re-Create Arsenal By Running arsenal_player
				execVM "cvo\arsenal\cvo_arsenal_player.sqf";
			}								// codeblock to be executed on completion
		] call CBA_fnc_progressBar;			// Executing a CBA progressBar from an Ace Interaction results in crash. Delay execution by 1 frame!!!
	}] call CBA_fnc_execNextFrame;			// <- this will delay the execution by 1 Frame. 
}; 											// This is the code you want the interaction to execute.

_cvo_updateArsenal = [
	"CVO_Arsenal_updateArsenal",										// Action Name
	"Talk to the Quatermaster (Update your Arsenal)",					// Name for the ACE Interaction Menu
	"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",		// Icon
	_code2,																// the code you're executing
	{true}																// Condition
] call ace_interact_menu_fnc_createAction;

// Here we Attach the Action to the Object
{
	[
		_x,														// OBJECT the action should be assigned to
		0,														// Type of action, 0 for action, 1 for self-actionIDs
		["ACE_MainActions"],									// Parent path of the new action <Array>
		_cvo_updateArsenal
	] call ace_interact_menu_fnc_addActionToObject;				// Alternative: ace_interact_menu_fnc_addActionToObject 
} forEach CVO_arsenal_paperwork;





