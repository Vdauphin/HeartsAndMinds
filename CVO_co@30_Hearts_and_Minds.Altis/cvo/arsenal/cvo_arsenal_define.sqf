/*
	Author: CVO - Mr. Zorn

	Description:
		Defines Equipment


	Returns:
		<>

	Examples:
*/


/*=================================================*
	CVO_ARSENAL_DEFINE
*=================================================*

Here, you define the Available Equipment for the CVO Arsenal
It is seperated in 3 Parts

##################
1. BASE KIT - This is Available for Everyone
##################

Variable Name: CVO_A_BASE = [];

For easier reading it is suggested to compartmentalise
and append the individual Groups to CVO_A_BASE



##################
### 2. ROLE KIT - This is dependent on the Players Role.
##################

Traits like "Medic" or "Engineer" are automatically detected,
meaning manually giving a player the medic or doctor trait isnt necessary.

##################
3. Personal KIT - Add Items to individual players based on their UID(steam64)
##################

This is based on Code blocks to allow for checks.

##################

BASE KIT gets defined once in the beginning, as it will never change during during mission.

ROLE KIT gets updated each time the arsenal opens as Roles and Traits might change mid-mission (Ad-hoc Medic)
PLAYER KIT gets updated each time the arsenal opens as it CAN be dependend on other Roles and Traits as well.


##################


*=================================================*/  


if (!hasInterface) exitWith {};

// #####################################################
// ###### DEFINE ARSENAL BOXES HERE - objects that give accesss to the CVO Arsenal
// #####################################################
// ###### Ether Define the CVO_Arsenal_Boxes directly via array or by putting all boxes in one layer called "CVO_ARSENAL_BOXES"
// #####################################################

CVO_Arsenal_boxes = [];

/*CVO_arsenal_boxes append [
	cvo_arsenal_1,
	cvo_arsenal_2,
	cvo_arsenal_3,
	cvo_arsenal_4,
	cvo_arsenal_5,
	cvo_arsenal_6,
	cvo_arsenal_7,
	cvo_arsenal_8,
	cvo_arsenal_9,
	cvo_arsenal_10,
	cvo_arsenal_11
];
*/

private _layerArray = getMissionLayerEntities "cvo_arsenal_boxes";
if (!(_layerArray isEqualTo [])) then {CVO_Arsenal_boxes append getMissionLayerEntities "cvo_arsenal_boxes" # 0;};


// #####################################################
// ###### DEFINE BASE KIT HERE - AVAILABLE FOR EVERYONE
// #####################################################

CVO_A_BASE = [];

// ###### Baseline Equipment ###### 
// The Following can be mostly left as default

// Medical 
CVO_A_BASE append [
	"ACE_packingBandage",
	"ACE_fieldDressing",
	"ACE_tourniquet", 
	"ACE_splint",
	"ACE_morphine",
	"ACE_epinephrine", 
	"ACE_salineIV", 
	"ACE_salineIV_500",
	"ACE_salineIV_250",
	"ACE_personalAidKit",
	"ACE_bodyBag"];

// Tools & Equipment
CVO_A_BASE append [
	"ChemicalDetector_01_watch_F",

	"immersion_pops_poppack",
	"murshun_cigs_cigpack",
	"murshun_cigs_lighter",
	"murshun_cigs_matches",
	"immersion_cigs_cigar0",
	"immersion_cigs_cigar0_nv",

	"ACE_Humanitarian_Ration",

	"ACE_MapTools",
	"ace_marker_flags_yellow",
	"ace_marker_flags_red",
	"ace_marker_flags_green",
	"ace_marker_flags_blue",

	"ACE_EntrenchingTool",
	"ACE_EarPlugs",

	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",

	"ACE_DAGR",
	"ACE_CableTie",
	"ACE_Chemlight_Shield",
	"acex_intelitems_notepad",
	"ACE_Flashlight_KSF1",

	"ACE_WaterBottle",

	"tsp_paperclip",

	"ItemWatch",
	"ItemCompass"];

// Binoculars
CVO_A_BASE append [
	//"Hate_Smartphone_HUD", "Hate_Smartphone",
	"Nikon_DSLR_HUD",
	"Nikon_DSLR",
	"Old_Camera_HUD",
	"Old_Camera",
	"Old_Camera_Color_HUD",
	"Old_Camera_Color",
	"Binocular"];

// NVGs
CVO_A_BASE append [];


// Rappeling Rope 
CVO_A_BASE append [
	//"AUR_Rappel_Rope_70",
	//"AUR_Rappel_Rope_50",
	//"AUR_Rappel_Rope_30",
	"AUR_Rappel_Rope_20",
	"AUR_Rappel_Rope_10",
	"AUR_Rappel_Gear"];

// Radios
CVO_A_BASE append  ["ACRE_BF888S"];

// ###### Wearables ###### 

// Uniforms 
CVO_A_BASE append [
	"ACM_APD_Clothes_Blouse",
	"ACM_APD_Clothes",
	"ACM_APD_2_Clothes",
	"U_Marshal"];

// Vests
CVO_A_BASE append [
	"V_Safety_blue_F",
	"V_TacVestIR_blk",
	"V_TacVest_blk_POLICE",
	"ACM_APD_Vest",
	"V_LegStrapBag_black_F",
	//unlock later
	//"V_SmershVest_01_black_F",				
	//"V_SmershVest_01_radio_black_F",
	"V_CarrierRigKBT_01_light_DarkOlive_F",
	"V_CarrierRigKBT_01_DarkOlive_F"];

// Backpacks
CVO_A_BASE append [
	"gm_ge_backpack_satchel_80_blk",
	"gm_pl_army_backpack_80_oli",
	"B_AssaultPack_blk",
	"B_LegStrapBag_black_F",
	"B_Messenger_Black_F"];

// Headgear
CVO_A_BASE append [
	"gm_gc_headgear_fjh_model4_wht",
	"ACM_APD_Cap",
	"H_Cap_police",
	"gm_ge_headgear_beret_un",
	"H_MilCap_blue"];

// Facewear
CVO_A_BASE append [
	"gm_gc_army_facewear_dustglasses",
	"G_Respirator_white_F",
	"G_Spectacles_Tinted",
	"G_Squares",
	"G_Squares_Tinted",
	"G_Spectacles",

	"immersion_pops_pop0",
	"murshun_cigs_cig0",
	"immersion_cigs_cigar0",

	"G_Aviator"				];

// ###### WEAPONS - MAIN ###### 

// Rifles
CVO_A_BASE append  [
	// Shotgun
	"gm_hk512_ris_wud",
	"gm_hk512_wud",
	"gm_7rnd_12ga_hk512_slug",
	"gm_7rnd_12ga_hk512_pellet",

	// MP5 + Variants
	"gm_mp5n_surefire_blk",
	"gm_mp5n_blk",
	"gm_mp5a5_blk",
	"gm_mp5a4_blk",
	"gm_mp5a3_surefire_blk",
	"gm_mp5a3_blk",
	"gm_mp5a2_blk",
	"gm_60Rnd_9x19mm_B_DM51_mp5a3_blk",
	"gm_60Rnd_9x19mm_B_DM11_mp5a3_blk",
	"gm_60Rnd_9x19mm_BSD_DM81_mp5a3_blk",
	"gm_60Rnd_9x19mm_AP_DM91_mp5a3_blk",
	"gm_30Rnd_9x19mm_B_DM51_mp5a3_blk",
	"gm_30Rnd_9x19mm_B_DM11_mp5a3_blk",
	"gm_30Rnd_9x19mm_BSD_DM81_mp5a3_blk",
	"gm_30Rnd_9x19mm_AP_DM91_mp5a3_blk",
	"gm_30Rnd_9x19mm_B_DM51_mp5_blk",
	"gm_30Rnd_9x19mm_B_DM11_mp5_blk",
	"gm_30Rnd_9x19mm_BSD_DM81_mp5_blk",
	"gm_30Rnd_9x19mm_AP_DM91_mp5_blk",

	// Attachments
	"gm_surefire_l75_ir_surefire_blk",
	"gm_surefire_l72_red_surefire_blk",
	"gm_surefire_l72_grn_surefire_blk",
	"gm_surefire_l60_red_surefire_blk",
	"gm_surefire_l60_ir_surefire_blk",
	"gm_surefire_l60_wht_surefire_blk",
	"gm_maglite_2d_hkslim_blk"];

// Pistols
CVO_A_BASE append [
	"gm_pn3_gry",		
	"gm_pimb_blk",
	"gm_pim_blk",
	"gm_8Rnd_9x18mm_B_pst_pm_blk",
	"gm_p210_blk",
	"gm_8Rnd_9x19mm_B_DM11_p210_blk",
	"gm_8Rnd_9x19mm_B_DM51_p210_blk",
	"gm_p1_blk",
	"gm_8Rnd_9x19mm_B_DM11_p1_blk",
	"gm_8Rnd_9x19mm_B_DM51_p1_blk",
	"gm_8Rnd_9x19mm_BSD_DM81_p1_blk",
	"gm_m49_blk",
	"gm_8Rnd_9x19mm_B_DM11_p210_blk",
	"gm_8Rnd_9x19mm_B_DM51_p210_blk",
	"gm_pm63_blk",
	"gm_pm63_handgun_blk",
	"gm_15Rnd_9x18mm_B_pst_pm63_blk",
	"gm_25Rnd_9x18mm_B_pst_pm63_blk",

	"gm_lp1_blk",
	"gm_1Rnd_265mm_smoke_single_vlt_DM24",
	"gm_1Rnd_265mm_smoke_single_org_DM22",
	"gm_1Rnd_265mm_smoke_single_yel_DM19",
	"gm_1Rnd_265mm_smoke_single_yel_gc",
	"gm_1Rnd_265mm_smoke_single_blu_gc",
	"gm_1Rnd_265mm_smoke_single_blk_gc",
	"gm_1Rnd_265mm_flare_multi_nbc_DM47",
	"gm_1Rnd_265mm_flare_multi_wht_DM25",
	"gm_1Rnd_265mm_flare_multi_red_DM23",
	"gm_1Rnd_265mm_flare_multi_grn_DM21",
	"gm_1Rnd_265mm_flare_multi_yel_DM20",
	"gm_1Rnd_265mm_flare_para_yel_DM16",
	"gm_1Rnd_265mm_flare_single_wht_DM15",
	"gm_1Rnd_265mm_flare_single_red_DM13",
	"gm_1Rnd_265mm_flare_single_grn_DM11",
	"gm_1Rnd_265mm_flare_single_yel_DM10",
	"gm_1Rnd_265mm_flare_single_wht_gc",
	"gm_1Rnd_265mm_flare_single_red_gc",
	"gm_1Rnd_265mm_flare_multi_red_gc",
	"gm_1Rnd_265mm_flare_single_grn_gc"];

// Handgrenades and Throwables
CVO_A_BASE append   [
	"gm_handgrenade_conc_dm51a1",
	"gm_handgrenade_conc_dm51",

	"ACE_M84",

	"ACE_HandFlare_Green",
	"ACE_HandFlare_Yellow",
	"ACE_HandFlare_Red",
	"ACE_HandFlare_White",

	"Chemlight_yellow",
	"Chemlight_red",
	"Chemlight_blue",
	"Chemlight_green",
	"ACE_Chemlight_Orange",
	"ACE_Chemlight_White",
	"ACE_Chemlight_HiWhite",
	"ACE_Chemlight_UltraHiOrange"];

// Explosives
CVO_A_BASE append [
	"tsp_popperCharge_auto_mag",
	"tsp_popperCharge_mag"];

// CBRN KIT
CVO_A_BASE append [
	"U_C_CBRN_Suit_01_Blue_F", 
	"G_AirPurifyingRespirator_01_F",
	"G_RegulatorMask_F", 
	"B_SCBA_01_F"];

// AD KIT

CVO_A_BASE append [
	// G3A3
		"gm_g3a3_blk",
		"gm_10Rnd_762x51mm_B_DM111_g3_blk",		//10Rnd Magazine
		"gm_20Rnd_762x51mm_B_DM111_g3_blk",		//20Rnd Magazine
		"gm_maglite_2d_hkslim_blk",
	// Uniform
		"ACM_APD_Clothes_3",
	// Helmets
		"gm_ge_headgear_m92_cover_blk",
		"gm_ge_headgear_m92_cover_glasses_blk",
	// Vests
		"gm_ge_bgs_vest_type3_gry",
		"gm_ge_bgs_vest_type18_blk",
		"gm_ge_bgs_vest_type3a1_gry"];


CVO_A_BASE append [		// M16A1 Kit

	"gm_20Rnd_556x45mm_B_M855_stanag_gry",		//20r Mags
	"gm_20Rnd_556x45mm_B_M193_stanag_gry",
	"gm_20Rnd_556x45mm_B_T_M856_stanag_gry",
	"gm_20Rnd_556x45mm_B_T_M196_stanag_gry",

//	"gm_30Rnd_556x45mm_B_T_M196_stanag_gry",	//30r Mags
//	"gm_30Rnd_556x45mm_B_T_M856_stanag_gry",
//	"gm_30Rnd_556x45mm_B_M193_stanag_gry",
//	"gm_30Rnd_556x45mm_B_M855_stanag_gry",
	

//	"gm_colt4x20_ar15_blk",						// Scope

//	"gm_suppressor_atec150_556mm_blk",			// Suppressor

	"gm_m16a1_blk"
];



// Lategame Uniforms and Wear
/*
CVO_A_BASE append [

	"eou_gorka_1",

	"U_O_R_Gorka_01_black_F",

	"U_B_GEN_Commander_F",

	"gm_ge_uniform_pilot_commando_rolled_blk",
	"gm_ge_uniform_pilot_commando_blk",
	"gm_ge_uniform_pilot_commando_rolled_gry",
	"gm_ge_uniform_pilot_commando_gry"

	"gm_ge_facewear_stormhood_dustglasses_blk",
	"gm_ge_facewear_stormhood_blk"	
	];
*/





// #####################################################
// ###### DEFINE ROLE KIT HERE - AVAILABLE FOR SPECIFIC ROLES
// #####################################################

// CUSTOM ROLES
// Formatting Template: [  "KEY/ROLENAME",	[  ["ARRAY OF CLASSNAMES"],{"Optional CODEBLOCK"}  ]  ]

CVO_A_HASH_RoleKit = createHashMapFromArray [
	["Medic", [[
		"gm_ge_backpack_satchel_80_san",

		"ACE_quikclot", 
		"ACE_elasticBandage", 
		"ACE_adenosine", 
		"ACE_plasmaIV",
		"ACE_plasmaIV_500",
		"ACE_plasmaIV_250",
		"ACE_bloodIV",
		"ACE_bloodIV_500",
		"ACE_bloodIV_250",
		"ACE_surgicalKit",
		"ACE_suture"],
	{}]],
	["Engineer", [[
		// Tools and Detectors
		"ACE_VMM3","ACE_VMH3", 
		"ACE_wirecutter", "ToolKit", 
		"ACE_Fortify", "ACE_DefusalKit",
		
		// Explosives
		"DemoCharge_Remote_Mag",	"ACE_DemoCharge_Remote_Mag_Throwable",
		"SatchelCharge_Remote_Mag",	"ACE_SatchelCharge_Remote_Mag_Throwable",

		"gm_explosive_plnp_charge",
		"gm_explosive_petn_charge",

		"tsp_frameCharge_mag",
		"tsp_stickCharge_mag",
		"tsp_stickCharge_auto_mag",

		// Uniforms
		"gm_ge_uniform_pilot_commando_rolled_gry",	"gm_ge_uniform_pilot_commando_rolled_blk",
		"gm_ge_uniform_pilot_commando_gry",			"gm_ge_uniform_pilot_commando_blk",

		"gm_ge_army_backpack_80_oli",
		"gm_ge_bgs_vest_type18_blk",
		"gm_ge_headgear_psh77_up_oli",				"gm_ge_headgear_psh77_down_oli"], 
		{}]],
	["Officer", [
		["H_Beret_blk",	"gm_ge_headgear_beret_blk"],
		{}	
	]] 
];

// #####################################################
// ###### DEFINE PLAYER KIT HERE - Based on STEAM64 ID
// #####################################################

// Formatting Template: [  "STEAM64",	["PlayerName", "["ARRAY OF CLASSNAMES"],{"Optional CODEBLOCK"}  ]  ]


CVO_A_HASH_PlayerKit = createHashMapFromArray [
	["_SP_PLAYER_", 		["Editor Debug", 	["ACE_Banana"],		{systemChat "this is a test"; 	["ACE_Banana"]}		]	],	
	["76561197970306509", 	["Zorn", 			[	"gm_pl_headgear_beret_blu",	"gm_ge_headgear_beret_un", "G_Spectacles_Tinted", "G_Balaclava_blk", "H_Beret_blk"],	{[]}	]],
	["76561198147307775", 	["Clone", 			[	"gm_pl_headgear_beret_blu",	"gm_ge_headgear_beret_un"],	{[]}	]] 	
];
