// Define Global Variables
// Array of Objects the CVO_Arsenal should be acessible from 
CVO_arsenal_boxes 		= [
	CVO_arsenal,
	CVO_arsenal_1,
	CVO_arsenal_2,
	CVO_arsenal_3,
	CVO_arsenal_4,
	CVO_arsenal_5,
	CVO_arsenal_6,
	CVO_arsenal_7,
	CVO_arsenal_8,
	CVO_arsenal_9,
	CVO_arsenal_10,
	CVO_arsenal_11,
	CVO_arsenal_12,
	CVO_arsenal_13
];

// Array of Objects to add the "paperwork" function (manual save current loadout)
CVO_arsenal_paperwork 	= [
	cvo_arsenal_loadout,
	cvo_arsenal_loadout_1,
	cvo_arsenal_loadout_2,
	cvo_arsenal_loadout_3,
	cvo_arsenal_loadout_4,
	cvo_arsenal_loadout_5,
	cvo_arsenal_loadout_6
];

// Primes the Arsenal Box Attributes - Only needs to be done once initially.
if (0 < count CVO_arsenal_boxes) then {
	{
		[_x, false] 				call ace_dragging_fnc_setDraggable;			// Disables Dragging
		[_x, false] 				call ace_dragging_fnc_setCarryable;			// Disables Carrying
		[_x, -1] 					call ace_cargo_fnc_setSize;					// Disables Ace Cargo Loading
		_x setVariable ["ace_cargo_noRename", true];							// Disables Ace Cargo Renaming
	} forEach CVO_arsenal_boxes;
};

// Loads the Arsenal Database
[compileScript ["cvo\arsenal\cvo_arsenal_basic.sqf"]] call CBA_fnc_directCall;

// adds Paperwork Interaction
[compileScript ["cvo\arsenal\cvo_arsenal_paperwork.sqf"]] call CBA_fnc_directCall;

// set default loadout at spawn
[] spawn {
	if (!hasInterface) exitWith {};
	sleep 20;
	player setVariable ["CVO_Loadout", getUnitLoadout player];
	diag_log ("[CVO] [LOADOUT] - " + str player + " - Loadout saved"); };

//// This really needs to be in initPlayerLocal.sqf for JIP

/* 
//// doesnt really seem to work ->>>> instead USE onPlayerResapwn.sqf

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

// [compileScript ["cvo\arsenal\cvo_arsenal_personalKit.sqf"]] call CBA_fnc_directCall;