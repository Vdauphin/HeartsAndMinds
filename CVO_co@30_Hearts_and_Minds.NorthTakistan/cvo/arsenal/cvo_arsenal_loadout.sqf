/*
 * Author: Dr. Zorn 
 * Adds an Ace Interaction to an object so players can safe their respawn loadout with a progressbar (5s) on said object.
 * Dependency: ACE, CBA
 * 
 *
 */

// Here you define the code you want to execute, in this case, via a progress bar

if (count CVO_arsenal_paperwork isEqualTo 0) exitWith {};

_code = {
	[{
		[
			"Filling out Paperwork... (saving Respawn Loadout)",		// Title of progressBar
			5,								// Duration of progressBar in secounds
			{true},							// Condition, will check every frame
			{
				player setVariable ["CVO_Loadout", getUnitLoadoutplayer];		// The actual fucking code
			}								// codeblock to be executed on completion
		] call CBA_fnc_progressBar;			// Executing a CBA progressBar from an Ace Interaction results in crash. Delay execution by 1 frame!!!
	}] call CBA_fnc_execNextFrame;			// <- this will delay the execution by 1 Frame. 
}; 											// This is the code you want the interaction to execute.


// Here we create the action which we later attach to something
_cvo_saveLoadout = [
	"CVO_Arsenal_Loadout",					// Action Name
	"Fillout the Stupid Armory Paperwork",	// Name for the ACE Interaction Menu
	"",										// Statement - i have no fucking clue what that is supposed to mean
	_code,									// the coe you're executing
	{true}									// Condition
] call ace_interact_menu_fnc_createAction;

// Here we define where we want this action that we created to be attached to

{
	[
		_x,														// Class the action should be assigned to
		0,														// Type of action, 0 for action, 1 for self-actionIDs
		["ACE_MainActions"],									// Parent path of the new action <Array>
		_cvo_saveLoadout
	] call ace_interact_menu_fnc_addActionToObject;				// Alternative: ace_interact_menu_fnc_addActionToObject 
} forEach CVO_arsenal_paperwork;