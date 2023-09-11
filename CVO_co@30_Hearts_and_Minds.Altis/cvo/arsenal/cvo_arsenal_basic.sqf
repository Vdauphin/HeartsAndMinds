if (count CVO_arsenal_boxes isEqualTo 0) exitWith {};


// Defining Custom Arsenal Pools
//// Basic Kit, for everyone
private _CVO_A_Basic_Medical = [
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
	"ACE_bodyBag"
];

private _CVO_A_Basic_RespawnTent = [
	"B_Respawn_TentA_F",
	"B_Respawn_Sleeping_bag_F",
	"B_Patrol_Respawn_bag_F",
	"B_Respawn_TentDome_F",
	"B_Respawn_Sleeping_bag_brown_F",
	"B_Respawn_Sleeping_bag_blue_F"
	];

private _CVO_A_Basic_Radios = ["ACRE_BF888S"];

private _CVO_A_Basic_Uniforms = [
    "ACM_APD_Clothes_Blouse",
	"ACM_APD_Clothes",
	"ACM_APD_2_Clothes",
	"U_Marshal"
];


private _CVO_A_Basic_Vests = [

	"V_Safety_blue_F",
	"V_TacVestIR_blk",
	"V_TacVest_blk_POLICE",
	"ACM_APD_Vest",
	"V_LegStrapBag_black_F",
// unlock later
//	"V_SmershVest_01_black_F",				
//	"V_SmershVest_01_radio_black_F",
	"V_CarrierRigKBT_01_light_DarkOlive_F",
	"V_CarrierRigKBT_01_DarkOlive_F"
];

private _CVO_A_Basic_Backpacks = [
	"gm_ge_backpack_satchel_80_blk",
	"gm_pl_army_backpack_80_oli",
	"B_AssaultPack_blk",

	"B_LegStrapBag_black_F",
	"B_Messenger_Black_F"
];

private _CVO_A_Basic_Helmets = [
	"gm_gc_headgear_fjh_model4_wht",
	"ACM_APD_Cap",
	"H_Cap_police",
	"gm_ge_headgear_beret_un",
	"H_MilCap_blue"
];

private _CVO_A_Basic_Face = [
	"gm_gc_army_facewear_dustglasses",

	"G_Respirator_white_F",
	"G_Spectacles_Tinted",
	"G_Squares",
	"G_Squares_Tinted",
	"G_Spectacles",
	"immersion_pops_pop0",
	"murshun_cigs_cig0",
	"immersion_cigs_cigar0",
	"G_Aviator"				
];

private _CVO_A_Basic_NightFight = [
	"rhs_acc_perst1ik_ris",
	"rhs_acc_perst1ik",
	"rhs_acc_perst3",
	"rhs_acc_perst3_top",
	"rhs_1PN138"
];

private _CVO_A_Basic_Bino = [
	//"Hate_Smartphone_HUD",
	//"Hate_Smartphone",
	"Nikon_DSLR_HUD",
	"Nikon_DSLR",
	"Old_Camera_HUD",
	"Old_Camera",
	"Old_Camera_Color_HUD",
	"Old_Camera_Color",
	"gm_df7x40_blk",
	"Binocular"
];
private _CVO_A_Basic_Tools = [
	"ChemicalDetector_01_watch_F",

	"ItemWatch",
	"ItemCompass",

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

	"tsp_paperclip"
];

private _CVO_A_Basic_Throwable =  [

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
	"ACE_Chemlight_UltraHiOrange"

];

private _CVO_A_Basic_EXO = [
	"tsp_popperCharge_auto_mag",
	"tsp_popperCharge_mag"
];

private _CVO_A_Basic_Rifles = [
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
	"gm_maglite_2d_hkslim_blk"
];

private _CVO_A_Basic_Pistols = [
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
	"gm_1Rnd_265mm_flare_single_grn_gc"
];

private _CVO_A_Basic_attachments = [
	// lights
	// muzzle
	// optics
];



private _CVO_A_Basic_enhanced_basic = [
];


private _CVO_A_Basic_suppressed = [
];

private _CVO_A_Basic_suppressors = [
];


private _CVO_A_Basic_Uniforms_SpecOps = [
];

private _CVO_A_Basic_FaceCamo = [
];

private _CVO_A_Basic_Rappeling = [
//	"AUR_Rappel_Rope_70",
//	"AUR_Rappel_Rope_50",
//	"AUR_Rappel_Rope_30",
	"AUR_Rappel_Rope_20",
	"AUR_Rappel_Rope_10",
	"AUR_Rappel_Gear"
];

private _CVO_A_Basic_personalCBRN = [
	"U_C_CBRN_Suit_01_Blue_F", 
	"G_AirPurifyingRespirator_01_F",
	"G_RegulatorMask_F", 
	"B_SCBA_01_F"
];




private _CVO_A_Basic_AgiosDionysios_Package = [
	// G3A3
		"gm_g3a3_blk",
		"gm_10Rnd_762x51mm_B_DM111_g3_blk",		//10Rnd Magazine
		"gm_maglite_2d_hkslim_blk",
		// Uniform
	"ACM_APD_Clothes_3",
		// Helmets
	"gm_ge_headgear_m92_cover_blk",
	"gm_ge_headgear_m92_cover_glasses_blk",
		// Vests
	"gm_ge_bgs_vest_type3_gry",
	"gm_ge_bgs_vest_type18_blk",
	"gm_ge_bgs_vest_type3a1_gry"
];

private _CVO_A_Basic_for_later = [
"eou_gorka_1",
"U_O_R_Gorka_01_black_F",
"U_B_GEN_Commander_F",
"gm_ge_uniform_pilot_commando_rolled_blk",
"gm_ge_uniform_pilot_commando_blk",
"gm_ge_uniform_pilot_commando_rolled_gry",
"gm_ge_uniform_pilot_commando_gry"
];




CVO_A_Basic = [];
CVO_A_Basic append _CVO_A_Basic_Medical; 
CVO_A_Basic append _CVO_A_Basic_Radios; 
CVO_A_Basic append _CVO_A_Basic_Uniforms; 
CVO_A_Basic append _CVO_A_Basic_Vests; 
CVO_A_Basic append _CVO_A_Basic_Backpacks;
// CVO_A_Basic append _CVO_A_Basic_RespawnTent;

CVO_A_Basic append _CVO_A_Basic_Helmets;
CVO_A_Basic append _CVO_A_Basic_Face;
CVO_A_Basic append _CVO_A_Basic_NightFight;
CVO_A_Basic append _CVO_A_Basic_Bino;
CVO_A_Basic append _CVO_A_Basic_Tools;

CVO_A_Basic append _CVO_A_Basic_Throwable;
CVO_A_Basic append _CVO_A_Basic_EXO;
CVO_A_Basic append _CVO_A_Basic_Rifles;
CVO_A_Basic append _CVO_A_Basic_Pistols;
CVO_A_Basic append _CVO_A_Basic_attachments;
CVO_A_Basic append _CVO_A_Basic_enhanced_basic;
CVO_A_Basic append _CVO_A_Basic_suppressed;
CVO_A_Basic append _CVO_A_Basic_suppressors;
CVO_A_Basic append _CVO_A_Basic_Uniforms_SpecOps;
CVO_A_Basic append _CVO_A_Basic_Rappeling;
CVO_A_Basic append _CVO_A_Basic_personalCBRN;

CVO_A_Basic append _CVO_A_Basic_AgiosDionysios_Package;

// CVO_A_Basic append _CVO_A_Basic_for_later;

//// Specific Kit, for certain "Roles" only

CVO_A_Officer = [
//	"ACRE_PRC148",
	"H_Beret_blk",
	"gm_ge_headgear_beret_blk"
];

CVO_A_Interpreter = [
	"tsp_lockpick"
];

CVO_A_TeamLeader = [
//	"ACRE_PRC148"
];

CVO_A_GL = [
];

CVO_A_RTO = [
];

CVO_A_Medic = [
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
	"ACE_suture"];

CVO_A_MG = [
	// accessoires 
	"ACE_SpareBarrel_Item"
	];

CVO_A_Marksman = [

	"ACE_RangeCard",
	"ace_gunbag_Tan",
	"ace_gunbag"
];

CVO_A_AT = [
	];

CVO_A_AA = [
	];

CVO_A_Engineer = [
	"ACE_VMM3","ACE_VMH3", 

	"ACE_wirecutter", "ToolKit", 

	"ACE_Fortify", "ACE_DefusalKit",
	
	"DemoCharge_Remote_Mag",
	"ACE_DemoCharge_Remote_Mag_Throwable",

	"SatchelCharge_Remote_Mag",
	"ACE_SatchelCharge_Remote_Mag_Throwable",

	"gm_explosive_plnp_charge",
	"gm_explosive_petn_charge",

	"tsp_frameCharge_mag",

	"tsp_stickCharge_mag",
	"tsp_stickCharge_auto_mag",

	"gm_ge_uniform_pilot_commando_rolled_gry",
	"gm_ge_uniform_pilot_commando_rolled_blk",
	"gm_ge_uniform_pilot_commando_gry",
	"gm_ge_uniform_pilot_commando_blk",

	"gm_ge_bgs_vest_type18_blk",
	"gm_ge_headgear_psh77_up_oli",
	"gm_ge_headgear_psh77_down_oli",
	"gm_ge_army_backpack_80_oli"
	
];




CVO_A_EW = [
	"hgun_esd_01_F",
	"muzzle_antenna_01_f",
	"muzzle_antenna_02_f",
	"muzzle_antenna_03_f",

	"ACE_UAVBattery",
	"B_UavTerminal",
	//"B_UAV_01_backpack_F",
	"B_UAV_06_backpack_F",					// Transport one
	"B_UGV_02_Demining_backpack_F",			// Eddie
	"B_UGV_02_Science_backpack_F"			// Eddie
]; 

CVO_A_Rifleman = [
	"tsp_paperclip"
];

_modLoaded = isClass (configfile >> "CfgPatches" >> "greenmag_main");
if (_modLoaded) then {[compileScript ["cvo\arsenal\cvo_arsenal_mod_greenmag.sqf"]] call CBA_fnc_directCall;};
