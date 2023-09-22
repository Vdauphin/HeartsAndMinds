diag_log ("[CVO] [INIT] (cvo_init.sqf) - START");

// Init CVO Music
cvo_fnc_music = compile preprocessFile "cvo\misc\cvo_music.sqf";
// Attaches Zeus Interaction to manually start music. 
["INITZEUS"] call cvo_fnc_music;

// Init CVO Arsenal
[compileScript ["cvo\arsenal\cvo_arsenal_init.sqf"]] call CBA_fnc_directCall;


// Init SideMission Condition
// cvo_side_fnc_distanceCondition = compile preprocessFile "core\fnc\side\cvo_side_fnc_distanceCondition.sqf";


// Init CVO fullHeal at Unimog Medical
["gm_ge_ff_u1300l_medic"] call CVO_Others_fnc_fullHeal;


// Init CVO Foritfy Preset
[compileScript ["cvo\logistics\cvo_logistics_init_fortify.sqf"]] call CBA_fnc_directCall;


// Initialize Logistics module
[compileScript ["cvo\logistics\init.sqf"]] call CBA_fnc_directCall;


// Initialize CSC module
[compileScript ["cvo\CSC\cvo_CSC_init.sqf"]] call CBA_fnc_directCall;


// Init CVO Custom Spawnable Objects
//cvo_p_logistics_custom_construction_array
// init to be found in /core/def/mission.sqf

// #### Init Sandstorm
// execVM "cvo\sandstorm\cvo_ss_init.sqf";

// Init CVO Environment Night Time Multiplyer
[compileScript ["cvo\env\cvo_env_init.sqf"]] call CBA_fnc_directCall;

// Init CVO Intel - Placeable Flag to Marker
[compileScript ["cvo\intel\cvo_intel_flag_init.sqf"]] call CBA_fnc_directCall;


// Starts Server Restart Message + Save Script
//execVM "cvo\misc\cvo_server_restart.sqf";

// Init JND Debug Console
execVM "cvo\misc\JND_debugv2.sqf";

// Init Players Job Board
execVM "cvo\misc\cvo_jobboard.sqf";

// Init Support Drones
// execVM "cvo\support\cvo_support_init.sqf";

// Init Map Module
 execVM "cvo\map\cvo_map_init.sqf";


// Init for CVO IED's
execVM "cvo\IED\cvo_ied_init.sqf";

// Define Misc Functions
// cvo_misc_fnc_gateAnimation = compile preprocessFile "cvo\misc\cvo_gateAnimation.sqf";

cvo_debug = false;

//CVO Earthquake Function
//cvo_misc_fnc_eq = compile preprocessFile "cvo\misc\cvo_eq.sqf";

diag_log ("[CVO] [INIT] (cvo_init.sqf) - END");
