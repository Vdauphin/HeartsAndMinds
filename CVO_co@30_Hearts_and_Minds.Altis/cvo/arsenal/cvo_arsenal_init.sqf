if (!hasInterface) exitWith {};

// Inits the arsenal data-base
[compileScript ["cvo\arsenal\cvo_arsenal_define.sqf"]] call CBA_fnc_directCall;

// #####################################################
// Functions
// #####################################################

cvo_A_fnc_update = 		compileScript ["cvo\arsenal\cvo_arsenal_fnc_update.sqf", 	false, ""];
cvo_A_fnc_open = 		compileScript ["cvo\arsenal\cvo_arsenal_fnc_open.sqf",  	false, ""];


// adds Paperwork Interaction
//	[compileScript ["cvo\arsenal\cvo_arsenal_paperwork.sqf"]] call CBA_fnc_directCall;

// set default loadout at spawn
// sleep due to some BTC HAM Internal wierdness

if (false) then {
	[] spawn {
		if (!hasInterface) exitWith {};
		sleep 20;
		player setVariable ["CVO_Loadout", getUnitLoadout player];
		diag_log ("[CVO] [LOADOUT] - " + str player + " - Loadout saved"); 
	};
} else {
	[] call {
		if (!hasInterface) exitWith {};
		player setVariable ["CVO_Loadout", getUnitLoadout player];
		diag_log ("[CVO] [LOADOUT] - " + str player + " - Loadout saved"); 
	};
};

// #####################################################
// ###### ACE INTERACTIONS
// #####################################################

// Create Action
_action = [
	"CVO_Arsenal_Open",				// ActionName
	"Open the Arsenal",				// Name of the Action shown in the menu
	"\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa",		// Icon
	{[] call cvo_A_fnc_open},		// Statement (The actual Code)
	{true}							// condition
] call ace_interact_menu_fnc_createAction;
// Attach the Action

{
	[
		_x, 
		0, 
		["ACE_MainActions"], 
		_action
	] call ace_interact_menu_fnc_addActionToObject;	
} forEach CVO_arsenal_boxes;


// #####################################################
// ###### EVENT HANDLERS
// #####################################################

	// ARESENAL CLOSED - Save Loadout
		["ace_arsenal_displayClosed", {
			player setVariable ["CVO_Loadout", getUnitLoadout player];
			diag_log ("[CVO] [LOADOUT] - " + str player + " - Loadout saved");
		}] call CBA_fnc_addEventHandler;


	// adds EH when respawning, using the previously saved loadout  
	player addEventHandler ["Respawn", {
		params ["_unit", "_corpse"]; 
		player setUnitLoadout (player getVariable ["CVO_Loadout", []]);
		diag_log ("[CVO] [LOADOUT] - " + str player + " - Loadout loaded"); 
	}];                                 

/* // Not needed anymore due to coming with its own Medical Tab Now
// #####################################################
// ###### MEDICAL TAB
// #####################################################

	private _medicalTab = [
		"ACE_quikclot", "ACE_packingBandage","ACE_elasticBandage", "ACE_fieldDressing",
		"ACE_tourniquet", "ACE_splint",
		"ACE_morphine","ACE_epinephrine", "ACE_adenosine", 
		"ACE_salineIV", "ACE_salineIV_500","ACE_salineIV_250",
		"ACE_plasmaIV","ACE_plasmaIV_500","ACE_plasmaIV_250",
		"ACE_bloodIV","ACE_bloodIV_500","ACE_bloodIV_250",
		"ACE_personalAidKit","ACE_bodyBag",
		"ACE_surgicalKit","ACE_suture"
	];
	[_medicalTab, "Medical", getMissionPath "\cvo\arsenal\img\whiteCrystal.paa"] call ace_arsenal_fnc_addRightPanelButton;
	diag_log "[CVO] [ARSENAL] - Medical Tab Applied";
*/

// #####################################################
// ###### greenMag TAB
// #####################################################

CVO_A_modLoaded_GreenMag = isClass (configfile >> "CfgPatches" >> "greenmag_main");
if (CVO_A_modLoaded_GreenMag) then {
	// Creates List of all GreenMag Classnames
		private _greenTab = "('greenmag' in configName _x) && !('core' in configName _x)" configClasses (configFile >> "CfgWeapons") apply {configName _x};

	// Creates GreenMag Arsenal Tab
		[_greenTab, "greenMag", getMissionPath "\cvo\arsenal\img\greenMag.paa"] call ace_arsenal_fnc_addRightPanelButton;
		diag_log "[CVO] [ARSENAL] - Green Tab Applied";
};

diag_log ("[CVO] [LOADOUT] - " + str player + " - init completed");