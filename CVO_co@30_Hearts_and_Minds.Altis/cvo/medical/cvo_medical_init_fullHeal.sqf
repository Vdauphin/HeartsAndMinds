/*
 * Author: Dr. Zorn 
 * Adds an Ace Interaction to a vehicle class so players can perform a fullheal with a progressbar (30s) on said vehicle.
 * Dependency: ACE, CBA
 * 
 *
 */



// Here you define the code you want to execute, in this case, via a progress bar
_code = {
	if (round random 100 < 5) then {
		playSound3D [getMissionPath "cvo\medical\medical_healsound.ogg", player];
	};
	[{
		[
			"Get Treated...",												// Title of progressBar
			30,																// Duration of progressBar in secounds
			{true},															// Condition, will check every frame
			{
				[player] call ace_medical_treatment_fnc_fullHealLocal;		// The actual fucking code
			}																// codeblock to be executed on completion
		] call CBA_fnc_progressBar;											// Executing a CBA progressBar from an Ace Interaction results in crash. Delay execution by 1 frame!!!
	}] call CBA_fnc_execNextFrame;											// <- this will delay the execution by 1 Frame. 
}; 																			// This is the code you want the interaction to execute.


// Here we create the action which we later attach to something
_cvo_fullAceHeal = [
	"CVO_FullHeal",									// Action Name
	"Get Full Health Check",						// Name for the ACE Interaction Menu
	"cvo\img\redCrystal.paa",						// custom Icon
	_code,											// Statement - the coe you're executing
	{true}											// Condition
] call ace_interact_menu_fnc_createAction;


// Here we define where we want this action that we created to be attached to
[
	"gm_ge_ff_u1300l_medic",						// Class the action should be assigned to
	0,												// Type of action, 0 for action, 1 for self-actionIDs
	["ACE_MainActions"],							// Parent path of the new action <Array>
	_cvo_fullAceHeal
] call ace_interact_menu_fnc_addActionToClass;		// Alternative: ace_interact_menu_fnc_addActionToObject 



