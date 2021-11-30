btc_custom_loc = [
/*
    DESCRIPTION: [POS(Array),TYPE(String),NAME(String),RADIUS (Number),IS OCCUPIED(Bool)]
    Possible types: "NameVillage","NameCity","NameCityCapital","NameLocal","Hill","Airport","NameMarine", "StrongpointArea", "BorderCrossing", "VegetationFir"
    EXAMPLE: [[13132.8,3315.07,0.00128174],"NameVillage","Mountain 1",800,true]
*/
[[10495.3,7565.11,0.00116634],"StrongpointArea","Checkpoint Franhtka",300,true],
[[5587.56,5187.63,0],"NameVillage","Al Djozal",500,true],
[[3182.21,4651.11,0],"NameVillage","Al Mars Haiy",400,true],
[[6570.02,9010.75,0],"NameVillage","Al Monha Kho",500,true],
[[6316.12,7649.76,0],"NameVillage","Al Talibhé",300,true],
[[4849.98,7584.96,0],"NameVillage","Walid St York",500,true],
[[5329.34,6044.63,0],"NameVillage","Al KrimTarbka",500,true],
[[4817.35,5459.56,0],"NameVillage","Al Majdid",400,true],
[[18822.6,5054.56,0],"NameVillage","Al Saoudi",400,true],
[[17431.1,7420.71,0],"NameVillage","Al MaiKouy West",500,true],
[[18698.2,6614.82,0],"NameVillage","Al MaiKouy South",500,true],
[[19707.3,7115.92,0],"NameVillage","Al MaiKouy East",500,true],
[[13661.3,1767.47,0],"NameLocal","Four Dahgy",300,true],
[[4759.64,8970.23,0],"Airport","Al Navion",400,true],
[[18839.8,18947,0],"Airport","Al Cesnnah",700,true],
[[18467.7,3602.0,0],"Airport","Al Boying",300,true],
[[10141,5667.87,0],"NameLocal","Fayarhan",400,true],
[[11032.6,2157.21,0],"NameLocal","Usine Schmack",200,true],
[[16965,16759.4,0],"NameLocal","Mahkroudi",200,true],
[[17212.7,12383.2,0],"NameLocal","Barhounha",200,true],
[[10973.9,6350.85,0],"NameLocal","Fort Kamlesh",300,true],
[[18632.8,1811.77,0],"NameVillage","Dubhay Gazoil",700,true],
[[11607.6,9790.37,0],"NameVillage","Frah Anhk",400,true],
[[7038.16,11255.2,0],"NameVillage","Al Payich",500,true],
[[11626,9796.16,0],"NameVillage","Sarhvaha",500,true],
[[19697.3,10024.1,0],"NameVillage","Bordhurn",500,true],
[[4338.57,12146.1,0.00143051],"NameVillage","Usine Frahnia",300,true],
[[16147.7,8655.96,0.0015564],"NameLocal","Frachilha",300,true],
[[5749.11,16532,0.00153351],"NameVillage","Al Vahoub",400,true]
];

/*
    Here you can tweak spectator view during respawn screen.
*/
BIS_respSpecAi = true;                   // Allow spectating of AI
BIS_respSpecAllowFreeCamera = false;     // Allow moving the camera independent from units (players)
BIS_respSpecAllow3PPCamera = false;      // Allow 3rd person camera
BIS_respSpecShowFocus = false;           // Show info about the selected unit (dissapears behind the respawn UI)
BIS_respSpecShowCameraButtons = true;    // Show buttons for switching between free camera, 1st and 3rd person view (partially overlayed by respawn UI)
BIS_respSpecShowControlsHelper = true;   // Show the controls tutorial box
BIS_respSpecShowHeader = true;           // Top bar of the spectator UI including mission time
BIS_respSpecLists = true;                // Show list of available units and locations on the left hand side

/*
    Here you can specify which equipment should be added or removed from the arsenal.
    Please take care that there are different categories (weapons, magazines, items, backpacks) for different pieces of equipment into which you have to classify the classnames.
    In all cases, you need the classname of an object.

    Attention: The function of these lists depends on the setting in the mission parameter (Restrict arsenal).
        - "Full": here you have only the registered items in the arsenal available.
        - "Remove only": here all registered items are removed from the arsenal. This only works for the ACE3 arsenal!

    Example(s):
        private _weapons = [
            "arifle_MX_F",          //Classname for the rifle MX
            "arifle_MX_SW_F",       //Classname for the rifle MX LSW
            "arifle_MXC_F"          //Classname for the rifle MXC
        ];

        private _items = [
            "G_Shades_Black",
            "G_Shades_Blue",
            "G_Shades_Green"
        ];
*/
private _weapons = [];
private _magazines = [];
private _items = [];
private _backpacks = [];

btc_custom_arsenal = [_weapons, _magazines, _items, _backpacks];

/*
    Here you can specify which equipment is loaded on player connection.
*/

private _radio = ["tf_anprc152", "ACRE_PRC148"] select (isClass(configFile >> "cfgPatches" >> "acre_main"));
//Array of colored item: 0 - Desert, 1 - Tropic, 2 - Black, 3 - forest
private _uniforms = ["U_B_CombatUniform_mcam", "U_B_CTRG_Soldier_F", "U_B_CTRG_1", "U_B_CombatUniform_mcam_wdl_f"];
private _uniformsCBRN = ["U_B_CBRN_Suit_01_MTP_F", "U_B_CBRN_Suit_01_Tropic_F", "U_C_CBRN_Suit_01_Blue_F", "U_B_CBRN_Suit_01_Wdl_F"];
private _uniformsSniper = ["U_B_FullGhillie_sard", "U_B_FullGhillie_lsh", "U_B_T_FullGhillie_tna_F", "U_B_T_FullGhillie_tna_F"];
private _vests = ["V_PlateCarrierH_CTRG", "V_PlateCarrier2_rgr_noflag_F", "V_PlateCarrierH_CTRG", "V_PlateCarrier2_wdl"];
private _helmets = ["H_HelmetSpecB_paint2", "H_HelmetB_Enh_tna_F", "H_HelmetSpecB_blk", "H_HelmetSpecB_wdl"];
private _hoods = ["G_Balaclava_combat", "G_Balaclava_TI_G_tna_F", "G_Balaclava_combat", "G_Balaclava_combat"];
private _hoodCBRN = "G_AirPurifyingRespirator_01_F";
private _laserdesignators = ["Laserdesignator", "Laserdesignator_03", "Laserdesignator_01_khk_F", "Laserdesignator_01_khk_F"];
private _night_visions = ["NVGoggles", "NVGoggles_INDEP", "NVGoggles_OPFOR", "NVGoggles_INDEP"];
private _weapons = ["arifle_MXC_F", "arifle_MXC_khk_F", "arifle_MXC_Black_F", "arifle_MXC_Black_F"];
private _weapons_machineGunner = ["arifle_MX_SW_F", "arifle_MX_SW_khk_F", "arifle_MX_SW_Black_F", "arifle_MX_SW_Black_F"];
private _weapons_sniper = ["arifle_MXM_F", "arifle_MXM_khk_F", "arifle_MXM_Black_F", "arifle_MXM_Black_F"];
private _bipods = ["bipod_01_F_snd", "bipod_01_F_khk", "bipod_01_F_blk", "bipod_01_F_blk"];
private _pistols = ["hgun_P07_F", "hgun_P07_khk_F", "hgun_P07_F", "hgun_P07_khk_F"];
private _launcher_AT = ["launch_B_Titan_short_F", "launch_B_Titan_short_tna_F", "launch_O_Titan_short_F", "launch_B_Titan_short_tna_F"];
private _launcher_AA = ["launch_B_Titan_F", "launch_B_Titan_tna_F", "launch_O_Titan_F", "launch_B_Titan_tna_F"];
private _backpacks = ["B_AssaultPack_Kerry", "B_AssaultPack_eaf_F", "B_AssaultPack_blk", "B_AssaultPack_wdl_F"];
private _backpacks_big = ["B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_rgr", "B_Kitbag_rgr"];
private _backpackCBRN = "B_CombinationUnitRespirator_01_F";

btc_arsenal_loadout = [_uniforms, _uniformsCBRN, _uniformsSniper, _vests, _helmets, _hoods, [_hoodCBRN, _hoodCBRN, _hoodCBRN, _hoodCBRN], _laserdesignators, _night_visions, _weapons, _weapons_sniper, _weapons_machineGunner, _bipods, _pistols, _launcher_AT, _launcher_AA, _backpacks, _backpacks_big, [_backpackCBRN, _backpackCBRN, _backpackCBRN, _backpackCBRN], [_radio, _radio, _radio, _radio]];
