cvo_ied_fnc_failedIED 		= compileScript	["cvo\IED\cvo_ied_fnc_failedIED.sqf", 				false, ""];
cvo_ied_fnc_failedIED_fx 	= compileScript	["cvo\IED\cvo_ied_fnc_failedIED_fx.sqf", 			false, ""];
cvo_ied_fnc_delay_fx        = compileScript ["cvo\IED\cvo_ied_fnc_delay_fx.sqf",                false, ""];

CVO_weightedArrayIED = [
    "GrenadeHand",               5,
    "mini_Grenade",              5,
    "BombCluster_01_Ammo_F",    0.5, 
    "BombCluster_02_Ammo_F",    0.5, 
    "BombCluster_03_Ammo_F",    0.5, 
    "BombDemine_01_Ammo_F",       1,
    "M_Jian_AT",                1,
    "M_SPG9_HE",                1,
    "M_SPG9_HEAT",              1,
    "M_70mm_SAAMI",             1,
    "R_PG7_F",                  5,
    "R_80mm_HE",                1,
    "M_Scalpel_AT",             1, 
    "R_MRAAWS_HE_F",            1,
    "Bomb_04_F",                0.1,
    "Bo_GBU12_LGB_MI10",        0.5
];	

// if true exitWith {};

/*
params [
	["_classname", 			"", 		   [""]],
	["_needSetDamage", 		false, 		[false]],
	["_needDirectional", 	false, 		[false]],
	["_needSetVelocity", 	false, 		[false]],
	["_needAltitute", 		false, 		[false]],
	["_canCookOff", 		false, 		[false]],
	["_doesBlurry", 		false, 		[false]],
	["_doesHearing", 		false, 		[false]],
	["_canDelay",    	[true, 7], 	[[true, 7]]]
];
*/

CVO_weightedArrayIED = [
//      0                          1       2        3      4       5     6        7,    8          
//["classname",			 	  _setDmg, _setDir, [_setVel,[vector]], _aLti, _cook, _blurry, _hear, [canDelay, time], 1,

// very large -> very rare
["ammo_Missile_Cruise_01", 	  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 0.25,
["Bo_GBU12_LGB", 			  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 1,

// Large
["APERSBoundingMine_Range_Ammo", true,   false,   [false,[0,0,0]], false, false, true,  true,   [false,7]], 2,
["R_80mm_HE", 				  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["Rocket_04_HE_F", 			  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["BombDemine_01_Ammo_F",	  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,

// Medium
["Missile_AA_04_F",			  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["M_Titan_AP", 		 		  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["M_AT", 			  		  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["M_70mm_SAAMI", 			  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["M_Jian_AT", 				  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["R_TBG32V_F", 			  		false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,

// Small
["M_SPG9_HE",			  		false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["M_Scalpel_AT",			  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["ammo_Bomb_SDB",			  	false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["M_Titan_AT",			  		false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["M_SPG9_HEAT",			  		false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["M_NLAW_AT_F",			  		false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,
["R_MRAAWS_HEAT55_F",			false,   false,   [false,[0,0,0]], false, false, true,  true,   [true, 7]], 2,

// Hand Grenades
["mini_Grenade",		    	false,   false,   [false,[0,0,0]], false, true,  false, false,  [false,7]], 4,
["GrenadeHand",	        		false,   false,   [false,[0,0,0]], false, true,  false, false,  [false,7]], 4
];