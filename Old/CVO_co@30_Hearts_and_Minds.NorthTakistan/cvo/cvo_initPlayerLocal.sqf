diag_log ("[CVO] [INIT] (cvo_initPlayerLocal.sqf) - START");





[compileScript ["cvo\arsenal\cvo_arsenal_player.sqf"]] call CBA_fnc_directCall;

[compileScript ["cvo\misc\cvo_acre_unconcious.sqf"]] call CBA_fnc_directCall;

player addEventHandler ["Respawn", {
	player setUnitLoadout (player getVariable ["CVO_Loadout", []]);
}];

// Init Fast Travel for Vehicles
execVM "cvo\FTVic\cvo_FTVic_init.sqf";


diag_log ("[CVO] [INIT] (cvo_initPlayerLocal.sqf) - END");


