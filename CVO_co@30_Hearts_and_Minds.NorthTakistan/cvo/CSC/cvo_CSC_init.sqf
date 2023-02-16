cvo_CSC_fnc_addCSC = 		compileScript ["cvo\CSC\cvo_CSC_fnc_addCSC.sqf", 	false, ""];
cvo_CSC_fnc_spawnCSC = 		compileScript ["cvo\CSC\cvo_CSC_fnc_spawnCSC.sqf", 	false, ""];

 
// ################
// EXAMPLE USAGE
// 
/*
[
	btc_create_object, 
	"Monkey Care Package",
	[
		["Ace_banana", 100],
		["Ace_banana", 100]
	],
	"Land_WoodenCrate_01_F"
] call cvo_CSC_fnc_addCSC;
*/

_cvo_csc_source = "UK3CB_KDF_O_Gaz66_Ammo";


[
	_cvo_csc_source, 
	"Basic Ammo Package",
	[
		["rhs_10Rnd_762x54mmR_7N1", 30],
		["rhs_30Rnd_545x39_7N10_AK", 30],
		["rhs_100Rnd_762x54mmR_green", 6],
		["greenmag_beltlinked_762x54_basic_100",10],
		["greenmag_ammo_762x54_basic_60Rnd",10],
		["greenmag_ammo_762x39_basic_60Rnd",20],
		["greenmag_ammo_545x39_basic_60Rnd",5],
		["greenmag_item_speedloader",5]
		
	],
	"rhs_3Ya40_1_single"
] call cvo_CSC_fnc_addCSC;


[
	_cvo_csc_source, 
	"Medical Package",
	[
		["ACE_surgicalKit", 1],
		["ACE_suture", 50],

		["ACE_bodyBag", 25],
		["ACE_personalAidKit", 15],
		
		["ACE_salineIV", 10],
		["ACE_salineIV_500", 20],

		["ACE_fieldDressing", 20],
		["ACE_packingBandage", 20],
		["ACE_elasticBandage", 50]

	],
	"ACE_medicalSupplyCrate_advanced"
] call cvo_CSC_fnc_addCSC;


[
	_cvo_csc_source, 
	"Combat Patrol Package",
	[
		["ACE_bodyBag", 10],
		["ACE_personalAidKit", 5],
		["ACE_salineIV_500", 5],
		["ACE_Humanitarian_Ration", 10],
		["ace_marker_flags_red", 25],
		["ace_marker_flags_green", 25],
		["ACE_EarPlugs", 10],
		["ACE_SpraypaintRed", 2],
		["ACE_CableTie", 20],
		["ACE_HandFlare_White", 10],
		["rhs_30Rnd_545x39_7N10_AK", 10],
		["rhs_weap_rsp30_white", 20],
		["rhs_VG40OP_white", 20],
		["ACE_fieldDressing", 20],
		["ACE_packingBandage", 20],
		["ACE_elasticBandage", 10]

	],
	"rhs_7ya37_1_single",
	[
		["B_Respawn_TentDome_F",1]
	]
] call cvo_CSC_fnc_addCSC;

[
	_cvo_csc_source, 
	"Night Fight Package",
	[
		["ACE_HandFlare_White", 50],
		["rhs_30Rnd_545x39_AK_green", 10],
		["rhs_weap_rsp30_white", 50],
		["rhs_VG40OP_white", 50],
		["rhs_weap_ak74m_gp25", 1]

	],
	"rhs_7ya37_1_single"
] call cvo_CSC_fnc_addCSC;

[
	_cvo_csc_source, 
	"PKM Package",
	[
		["rhs_weap_pkm",1],
		["rhs_100Rnd_762x54mmR", 5],
		["rhs_100Rnd_762x54mmR_green", 5],
		["greenmag_beltlinked_762x54_basic_100",20],
		["greenmag_item_speedloader",1]
	],
	"rhs_7ya37_1_single"
] call cvo_CSC_fnc_addCSC;



[
	_cvo_csc_source, 
	"Metis HAT Package",
	[
		["ACE_EntrenchingTool",1],
		["ace_compat_rhs_afrf3_metis_carry", 1],
		["ace_compat_rhs_afrf3_mag_9M131F", 3],
		["ace_compat_rhs_afrf3_mag_9M131M", 7]
	],
	"Land_WoodenCrate_01_F"							 
] call cvo_CSC_fnc_addCSC;


[
	_cvo_csc_source, 
	"CBRN Package",
	[
		["U_C_CBRN_Suit_01_Blue_F", 4],
		["G_RegulatorMask_F", 4],
		["ChemicalDetector_01_watch_F", 2]
	],
	"Land_PlasticCase_01_large_CBRN_F",									
	[
		["B_SCBA_01_F",4]
	]
] call cvo_CSC_fnc_addCSC;
