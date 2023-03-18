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

private _CVO_A_Basic_Radios = ["ACRE_PRC343"];

private _CVO_A_Basic_Uniforms = [
    "UK3CB_TKP_B_U_CIB_CombatUniform_BLK",
    "UK3CB_TKP_B_U_CIB_CombatUniform_Shortsleeve_BLK",
    "UK3CB_TKP_I_U_CIB_CombatUniform_DBLU",
    "UK3CB_TKP_O_U_CIB_CombatUniform_Ten_1",
    "UK3CB_TKP_I_U_CombatUniform_BLK",
    "UK3CB_TKP_I_U_QRF_CombatUniform_BLK",
    "UK3CB_TKP_I_U_Officer_BLK",
    "UK3CB_TKP_O_U_Officer_Blk",
    "UK3CB_TKP_O_U_QRF_CombatUniform_Blk",
    "UK3CB_TKP_O_U_CombatUniform_Blk"
];


private _CVO_A_Basic_Vests = [
	"rhs_belt_AK4_back",
    "UK3CB_TKP_B_V_TacVest_Tan",
    "UK3CB_TKP_B_V_TacVest_Blk",
    "UK3CB_TKP_B_V_GA_HEAVY_BLK",
    "UK3CB_TKP_B_V_GA_LITE_BLK",
    "UK3CB_TKP_I_V_6Sh92_Radio_Tan",
    "UK3CB_TKP_I_V_6Sh92_Tan",
    "UK3CB_TKP_I_V_6Sh92_Radio_Des",
    "UK3CB_TKP_I_V_6Sh92_Des",
    "UK3CB_TKP_I_V_6Sh92_Radio_Khk",
    "UK3CB_TKP_I_V_6Sh92_Khk",
    "UK3CB_TKP_I_V_6Sh92_Radio_Blk",
    "UK3CB_TKP_I_V_6Sh92_Blk",
    "UK3CB_TKP_O_V_6b23_medic_BLK",
    "UK3CB_TKP_O_V_6b23_ML_6sh92_radio_BLK",
    "UK3CB_TKP_O_V_6b23_ml_BLK"
];

private _CVO_A_Basic_Backpacks = [
	"B_Kitbag_rgr",
	"B_Kitbag_cbr",
	"rhs_tortila_black",
	"UK3CB_TKA_O_B_RIF_Khk",
	"UK3CB_TKA_O_B_RIF_Tan",
	"UK3CB_CW_SOV_O_EARLY_B_Sidor_RIF",
	"UK3CB_CW_SOV_O_LATE_B_Sidor_RIF",


    "UK3CB_TKA_O_B_ENG_Khk",
    "UK3CB_TKA_O_B_RIF_Khk",
    "UK3CB_TKP_O_B_ASS_BLK",
	"UK3CB_UN_B_B_ASS",
    "B_LegStrapBag_black_F",
    "B_Messenger_Black_F",
    "B_Messenger_Coyote_F",
    "B_Messenger_Gray_F",
    "rhs_rpg_empty",
    "rhs_rpg_2",
    "rhs_rpg_6b2",
    "rhs_rpg_6b3"
];

private _CVO_A_Basic_Helmets = [
    "UK3CB_TKP_I_H_Beret",
	"UK3CB_TKP_O_H_Beret",
    "UK3CB_TKP_O_H_Patrolcap_Blk",
    "UK3CB_TKP_B_H_Patrolcap_TAN",
    "UK3CB_TKA_O_H_6b7_1m_bala1_TAN",
    "UK3CB_TKA_O_H_6b7_1m_ess_bala1_TAN",
    "UK3CB_TKA_O_H_6b7_1m_bala2_DES",
	"UK3CB_ARD_B_H_Crew_Cap_Ess",
	"UK3CB_H_Crew_Cap_Ess",
	"UK3CB_H_Crew_Cap",
	"UK3CB_ARD_B_H_Crew_Cap",
	"UK3CB_ARD_B_H_Crew_Cap",
	"H_Cap_tan",
	"H_Cap_blk",
	"rhs_gssh18",
	"UK3CB_TKA_O_H_6b27m_Tan",
	"UK3CB_TKA_O_H_6b27m_ESS_Tan",
	"UK3CB_ADA_B_H_6b27m_ml_ESS_OLI",
	"UK3CB_ADA_B_H_6b27m_ml_OLI",

	"UK3CB_H_Beanie_02_GRY",
	"UK3CB_H_Beanie_02_BRN",
	"UK3CB_H_Beanie_02_BLK",
	"rhs_beanie_green"
];

private _CVO_A_Basic_Face = [
	"G_Respirator_white_F",				
    "rhsusf_shemagh_od",
    "rhsusf_shemagh2_od",
    "rhsusf_shemagh_tan",
    "rhsusf_shemagh2_tan",
    "rhs_scarf",
    "G_Bandanna_blk",
    "G_Bandanna_khk",
    "UK3CB_G_Balaclava2_BLK",
    "UK3CB_G_Balaclava2_DES",
    "G_Balaclava_blk",
	
    "G_Aviator",
	"rhs_googles_yellow",
	"rhs_googles_orange",
	"rhs_googles_clear",
	"rhs_googles_black",
	"G_Bandanna_beast",
	"G_Bandanna_tan",
	"G_Combat",
	"G_Lowprofile",
	"rhs_ess_black",
	"UK3CB_G_KLR_TAN",
	"UK3CB_G_KL_BLK",
	"UK3CB_G_KL_TAN",
	"UK3CB_G_Neck_Shemag",
	"UK3CB_G_Neck_Shemag_Tan",
	"UK3CB_G_Neck_Shemag_KLR_blk",
	"UK3CB_G_Neck_Shemag_KLR_tan",
	"UK3CB_G_Neck_Shemag_KL_blk"];

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
	//"Nikon_DSLR_HUD",
	//"Nikon_DSLR",
	"Old_Camera_HUD",
	"Old_Camera",
	"Old_Camera_Color_HUD",
	"Old_Camera_Color",
	"rhs_tr8_periscope_pip",
	"rhs_tr8_periscope",
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

	"ACE_WaterBottle"
];

private _CVO_A_Basic_Throwable =  [
	"rhs_mag_rdg2_white",
	"rhs_mag_rdg2_black",
	"rhs_mag_rgd5",

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
    "rhs_weap_ak74m_fullplum",
    "rhs_weap_ak74m_desert",
    "rhs_weap_ak74m_camo",
    "rhs_weap_ak74m",
//	"rhs_weap_ak105",
//	"rhs_weap_aks74u",
//	"rhs_weap_aks74un",
//	"rhs_weap_aks74n",
//	"rhs_weap_aks74n_2",
//	"rhs_weap_aks74",
//	"rhs_weap_aks74_2",
//	"rhs_weap_ak74n",
//	"rhs_weap_ak74n_2",
	
	"rhs_30Rnd_545x39_7N10_AK",
	"rhs_30Rnd_545x39_7N10_plum_AK",
	"rhs_30Rnd_545x39_7N10_desert_AK",
	"rhs_30Rnd_545x39_7N10_camo_AK",
	"rhs_30Rnd_545x39_AK_plum_green",
	"rhs_30Rnd_545x39_7N6M_plum_AK",
	"rhs_30Rnd_545x39_7N10_2mag_desert_AK",
	"rhs_30Rnd_545x39_7N10_2mag_camo_AK",
	"rhs_30Rnd_545x39_7N10_2mag_AK",
	
	"rhs_30Rnd_545x39_7N6_AK",
	"rhs_30Rnd_545x39_7N6M_AK",
	"rhs_30Rnd_545x39_AK_green",


//    "rhs_weap_ak104",
//    "rhs_weap_ak103",
	"rhs_weap_akm",
	"rhs_weap_akms",
	"rhs_30Rnd_762x39mm_89",
	"rhs_30Rnd_762x39mm_tracer",
	"rhs_30Rnd_762x39mm_polymer_89",
	"rhs_30Rnd_762x39mm_polymer_tracer",
	"rhs_30Rnd_762x39mm_bakelite_89",
	"rhs_30Rnd_762x39mm_bakelite_tracer",


//	"uk3cb_sks_01_sling",
//	"uk3cb_sks_01",
//	"uk3cb_10rnd_magazine_sks",
//	"uk3cb_muzzle_sks_bayonet",

//	"UK3CB_Enfield_Rail",
//	"UK3CB_Enfield_10rnd_Mag",
//	"UK3CB_Enfield_10rnd_Mag_YT",

	"rhs_weap_savz61",
	"rhsgref_20rnd_765x17_vz61",

	"rhs_weap_pp2000",
	"rhs_mag_9x19mm_7n21_44",
	"rhs_mag_9x19mm_7n21_20"
];

private _CVO_A_Basic_Pistols = [
//	"rhs_weap_pb_6p9",
//	"rhs_acc_6p9_suppressor",

	"rhs_weap_makarov_pm",
	"rhs_mag_9x18_8_57N181S",

	"rhs_weap_6p53",
	"rhs_18rnd_9x21mm_7N28",
	
	"rhs_weap_pya",
	"rhs_mag_9x19_17",


	"rhs_weap_rsp30_red",
	"rhs_weap_rsp30_green",
	"rhs_weap_rsp30_white",
	
	"tsp_meleeWeapon_mpl50_black",
	"tsp_meleeWeapon_ak"
];

private _CVO_A_Basic_attachments = [
	// lights
	"rhs_acc_2dpZenit",					
	"rhs_acc_2dpZenit_ris",

	// muzzle
//	"rhs_acc_dtkakm",
	"rhs_acc_dtk",
	"rhs_acc_dtk1983",
	"rhs_acc_dtk1",
	"rhs_acc_dtk3",
	"rhs_acc_dtk2",
	"rhs_acc_dtk1p",
	"rhs_acc_pgs64_74un",
	"rhs_acc_pgs64_74u",
	"rhs_acc_pgs64",
	"rhs_acc_dtk1l"

	// optics
//	"rhs_acc_1p63",
//	"rhs_acc_okp7_dovetail",
//	"rhs_acc_ekp8_02",
//	"rhs_acc_pkas"
];



private _CVO_A_Basic_enhanced_basic = [
	"rhs_weap_ak74m_zenitco01",
	"rhs_weap_ak104_zenitco01",
	"rhs_weap_ak103_zenitco01",
	"rhs_weap_ak105_zenitco01",
	"rhs_30Rnd_545x39_7N22_AK",
	"rhs_30Rnd_545x39_7N22_plum_AK",
	"rhs_30Rnd_545x39_7N22_desert_AK",
	"rhs_30Rnd_545x39_7N22_camo_AK",
	"rhs_acc_grip_rk6",
	"rhs_acc_grip_rk2",
	"rhs_acc_grip_ffg2",
	"rhs_acc_2dpzenit_ris",
	"rhs_acc_perst1ik_ris"
];


private _CVO_A_Basic_suppressed = [
	"rhs_weap_asval",
	"rhs_weap_asval_grip",
	"rhs_acc_perst3_2dp_light_h",
	"rhs_acc_perst3_2dp_h",
	"rhs_20rnd_9x39mm_SP6",
	"rhs_20rnd_9x39mm_SP5",
	"rhs_10rnd_9x39mm_SP6",
	"rhs_10rnd_9x39mm_SP5",
	"CVO_greenmag_ammo_9x39_basic_60Rnd"
];

private _CVO_A_Basic_suppressors = [
"rhs_acc_tgpv",
"rhs_acc_dtk4long",
"rhs_acc_dtk4short"
];


private _CVO_A_Basic_Uniforms_SpecOps = [
	"UK3CB_LSM_B_U_Crew_CombatSmock_09",
	"UK3CB_LSM_B_U_Crew_CombatSmock_06",
	"UK3CB_LSM_B_U_Crew_CombatSmock_05",
	"UK3CB_LSM_B_U_Crew_CombatSmock_03",
	"UK3CB_LSM_B_U_Crew_CombatSmock_02",
	"UK3CB_LSM_B_U_Crew_CombatSmock_01",

	"UK3CB_TKA_B_V_GA_LITE_BLK",
	"UK3CB_TKA_B_V_GA_HEAVY_BLK",
	"UK3CB_TKP_I_V_6Sh92_Radio_Blk",
	"UK3CB_TKP_I_V_6Sh92_Blk",

	"rhs_tortila_black",

	"UK3CB_H_Woolhat_BLK",
	"UK3CB_H_Beanie_02_BLK",
	"G_Bandanna_khk",
	"G_Bandanna_oli",
	"G_Balaclava_blk",
	"rhs_scarf"
];

private _CVO_A_Basic_FaceCamo = [
//	"FISH_Cream_Kit_Snow",
//	"FISH_Cream_Kit_Tropical",

	"FISH_Cream_Kit_Europe",
	"FISH_Cream_Kit_Desert"
];

private _CVO_A_Basic_Rappeling = [
//	"AUR_Rappel_Rope_70",
//	"AUR_Rappel_Rope_50",
//	"AUR_Rappel_Rope_30",
//	"AUR_Rappel_Rope_20",
	"AUR_Rappel_Rope_10",
	"AUR_Rappel_Gear"
];

private _CVO_A_Basic_personalCBRN = [
	"G_AirPurifyingRespirator_01_F"
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
// CVO_A_Basic append _CVO_A_Basic_enhanced_basic;
// CVO_A_Basic append _CVO_A_Basic_suppressed;
// CVO_A_Basic append _CVO_A_Basic_suppressors;
CVO_A_Basic append _CVO_A_Basic_Uniforms_SpecOps;
CVO_A_Basic append _CVO_A_Basic_FaceCamo;
CVO_A_Basic append _CVO_A_Basic_Rappeling;
CVO_A_Basic append _CVO_A_Basic_personalCBRN;

/*
private _CVO_A_Basic_csw = [
	"ace_compat_rhs_afrf3_mag_9M131M",
	"ace_compat_rhs_afrf3_mag_9M131F",
	"ace_compat_rhs_afrf3_metis_carry"
];

// CVO_A_Basic append _CVO_A_Basic_csw;		// for now, CSW only accessible via CSC
*/

//// Specific Kit, for certain "Roles" only

CVO_A_Officer = [
	"ACRE_PRC148",
	"G_Spectacles_Tinted",
	"UK3CB_TKP_B_H_Beret",
    "UK3CB_TKP_O_H_Patrolcap_Off_Blk",
    "UK3CB_TKP_B_H_Patrolcap_Off_TAN",
    "rhs_cossack_visor_cap",
	"H_Beret_blk",
	"rhs_cossack_visor_cap_tan"];

CVO_A_Interpreter = [
	"tsp_lockpick"
];

CVO_A_TeamLeader = [
	"ACRE_PRC148"
];

CVO_A_GL = [
	"rhs_weap_ak74m_fullplum_gp25",
    "rhs_weap_ak74m_gp25",
	"rhs_weap_akm_gp25",
//	"rhs_weap_akmn_gp25",
	"rhs_weap_aks74_gp25",
//	"rhs_weap_ak103_gp25",
	"rhs_weap_ak74n_gp25",
	"rhs_weap_ak74n_2_gp25",
	"rhs_weap_akms_gp25",
	"rhs_weap_aks74n_gp25",

	"rhs_VOG25",
	"rhs_VOG25P",
	"rhs_GRD40_White",
	"rhs_GDM40",
	"rhs_VG40OP_white",
	"rhs_VG40MD",
	"rhs_VG40SZ"

];

CVO_A_RTO = ["ACRE_PRC77",
	"ACRE_PRC148",
	"ACRE_VHF30108SPIKE",
	"ACRE_VHF30108",
	"ACRE_VHF30108MAST"];

CVO_A_Medic = [
	"rhs_medic_bag",
    "UK3CB_TKP_I_B_ASS_MED_TAN",
    "UK3CB_TKP_O_B_ASS_MED_BLK",
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


//	"rhs_weap_pkm",
//	"rhs_100Rnd_762x54mmR_7N13",
//	"rhs_100Rnd_762x54mmR",
//	"rhs_100Rnd_762x54mmR_green"


	"ACE_SpareBarrel_Item",

	"rhs_weap_rpk74m",
	"rhs_acc_dtkrpk",
	"rhs_45Rnd_545X39_7N10_AK",
	"rhs_45Rnd_545X39_AK_Green",
	"rhs_60Rnd_545X39_7N10_AK",


	"UK3CB_RPK",
	"rhs_75Rnd_762x39mm_tracer",
	"rhs_75Rnd_762x39mm_89",
	"rhs_75Rnd_762x39mm"


	];

CVO_A_Marksman = [
	"rhs_acc_1p78",			
	"rhs_acc_1p29",

	"UK3CB_SVD_OLD",
	"rhs_10Rnd_762x54mmR_7N1",

	"rhs_weap_svdp",
	"rhs_weap_svds",
	"rhs_acc_1pn34",
	"rhs_10Rnd_762x54mmR_7N14", 

	"rhs_acc_pso1m2",
	"ACE_RangeCard",
	"optic_khs_old",
	"rhsusf_acc_harris_swivel"	
];

CVO_A_AT = [
	"rhs_weap_rpg18",

	"rhs_weap_rpg7", 
	"rhs_acc_pgo7v",
	"rhs_rpg7_PG7V_mag",
	"rhs_rpg7_OG7V_mag"
	];

CVO_A_AA = [
	"rhs_weap_igla",
	"rhs_mag_9k38_rocket"];

CVO_A_Engineer = [
	"ACE_VMM3","ACE_VMH3", 

	"ACE_wirecutter", "ToolKit", 

	"ACE_Fortify", "ACE_DefusalKit",
	
	"DemoCharge_Remote_Mag",
	"ACE_DemoCharge_Remote_Mag_Throwable",

	// "SatchelCharge_Remote_Mag",
	// "ACE_SatchelCharge_Remote_Mag_Throwable",

	"rhs_ec75_sand_mag",
	"rhs_ec200_sand_mag",
	"rhs_ec400_sand_mag",

	"tsp_frameCharge_mag",

	"tsp_stickCharge_mag",
	"tsp_stickCharge_auto_mag"];


CVO_A_CBRN = [
	"U_C_CBRN_Suit_01_Blue_F", 
	"U_B_CBRN_Suit_01_White_F",
	"G_AirPurifyingRespirator_01_F",
	"G_RegulatorMask_F", 
	"B_SCBA_01_F"];

CVO_A_EW = [
	"hgun_esd_01_F",
	"muzzle_antenna_01_f",
	"muzzle_antenna_02_f",
	"muzzle_antenna_03_f",

	"ACE_UAVBattery",
	"B_UavTerminal",
	//"B_UAV_01_backpack_F",
	"B_UAV_06_backpack_F",
	"B_UGV_02_Demining_backpack_F",
	"B_UGV_02_Science_backpack_F"]; 

CVO_A_Rifleman = [
	"rhs_acc_1p78",
	
	"tsp_paperclip"
	];

CVO_A_Marksman_late = [
"rhs_weap_vss",
"rhs_weap_vss_grip",
"rhs_acc_pso1m21"
];

CVO_A_MG_late = [
"rhs_weap_pkp",
"rhs_100Rnd_762x54mmR_7BZ3",
"rhs_100Rnd_762x54mmR_7N26",
"rhs_100Rnd_762x54mmR_7BZ3"
];


// CVO_A_Marksman append CVO_A_Marksman_late;
// CVO_A_MG append CVO_A_MG_late;


_modLoaded = isClass (configfile >> "CfgPatches" >> "greenmag_main");
if (_modLoaded) then {[compileScript ["cvo\arsenal\cvo_arsenal_mod_greenmag.sqf"]] call CBA_fnc_directCall;};

if (count CVO_arsenal_boxes isEqualTo 0) exitWith {};

{
	[_x, false, false] 			call ace_arsenal_fnc_initBox;				// Initialises ACE Arsenal on boxes
	[_x, CVO_A_Basic, false] 	call ace_arsenal_fnc_addVirtualItems;		// Adds the basic list to the arsenal

	[_x, false] 				call ace_dragging_fnc_setDraggable;			// Disables Dragging
	[_x, false] 				call ace_dragging_fnc_setCarryable;			// Disables Carrying
	[_x, -1] 					call ace_cargo_fnc_setSize;					// Disables Ace Cargo Loading
	_x setVariable ["ace_cargo_noRename", true];							// Disables Ace Cargo Renaming
} forEach CVO_arsenal_boxes;

