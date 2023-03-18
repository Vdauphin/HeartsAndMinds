// Define Global Variables
// Array of Objects the CVO_Arsenal should be acessible from 
CVO_arsenal_boxes 		= [
	CVO_arsenal,
	CVO_arsenal_1,
	CVO_arsenal_2,
	CVO_arsenal_3,
	CVO_arsenal_4
	];
// Array of Objects to add the "paperwork" function (manual save current loadout)
CVO_arsenal_paperwork 	= [
	cvo_arsenal_loadout,
	cvo_arsenal_loadout_1,
	cvo_arsenal_loadout_2,
	cvo_arsenal_loadout_3,
	cvo_arsenal_loadout_4
	];

// Loads the Arsenal Database
[compileScript ["cvo\arsenal\cvo_arsenal_basic.sqf"]] call CBA_fnc_directCall;

// adds Paperwork Interaction
[compileScript ["cvo\arsenal\cvo_arsenal_loadout.sqf"]] call CBA_fnc_directCall;

// set default loadout at spawn
player setVariable ["CVO_Loadout", getUnitLoadout player]; diag_log ("[CVO] [LOADOUT] - " + str player + " - Loadout saved");                                                                                   

//// This really needs to be in initPlayerLocal.sqf for JIP

/*
// adds EH when respawning, using the previously saved loadout 
player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"]; 
	player setUnitLoadout (player getVariable ["CVO_Loadout", []]);
	diag_log ("[CVO] [LOADOUT] - " + str player + " - Loadout loaded"); 
}];                                 
*/

// adds EH setting the loadout when closing the arsenal
["ace_arsenal_displayClosed", {player setVariable ["CVO_Loadout", getUnitLoadout player]; diag_log ("[CVO] [LOADOUT] - " + str player + " - Loadout saved");}] call CBA_fnc_addEventHandler;      
diag_log ("[CVO] [LOADOUT] - " + str player + " - init completed");

// Init CVO Arsenal Tab
[compileScript ["cvo\arsenal\cvo_arsenal_Tab_medical.sqf"]] call CBA_fnc_directCall;


