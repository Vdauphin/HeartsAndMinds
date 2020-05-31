btc_custom_loc = [

[[2288,7341,0],"NameVillage","Ostrivka",300,300,true],
[[5446,4532,0],"NameVillage","Lymany",300,300,true],
[[6512,8263,0],"NameCity","Petrivka",300,300,true],
[[10530,3375,0],"NameVillage","Kairy",300,300,true],
[[9071,16388,0],"NameVillage","Osnova",300,300,true],
[[7622,10993,0],"NameCity","Kalynivka",300,300,true],
[[10940,13113,0],"Airport","Usine Sputnik",500,500,true],
[[11681,10203,0],"NameVillage","Carrière Est",300,300,true],
[[10858,11066,0],"NameVillage","Carrière Nord",300,300,true],
[[10427,10451,0],"NameVillage","Carrière Ouest",300,300,true],
[[10630,9543,0],"NameVillage","Carrière Sud",300,300,true],
[[15060,14090,0],"NameCity","Quartier Sud",400,400,true],
[[14399,14299,0],"NameCity","Quartier Ouest",400,400,true],
[[16882,15594,0],"Airport","Aéroport National Mokket",500,500,true],
[[8033,8200,0],"NameVillage","Prirechny",300,300,true],
[[17015,14887,0],"NameVillage","Nautsi",300,300,true],
[[13800,11968,0],"NameVillage","Verkhnetoulomski",300,300,true],
[[13885,10368,0],"NameVillage","Mine Tulomskiy Ouest",300,300,true],
[[14660,10559,0],"NameVillage","Mine Tulomskiy Est",300,300,true],
[[16088,6854,0],"Airport","Port de Mourmansk",300,300,true],
[[16568,4233,0],"NameCity","Baie de Teriberka",300,300,true],
[[14535,8155,0],"NameCity","Erika",300,300,true],
[[13664,7941,0],"NameVillage","Ostrov",400,400,true],
[[11827,16258,0],"NameLocal","Pirenga",300,300,true],
[[12543,16285,0],"NameLocal","Laplandsky",300,300,true],
[[6325,17640,0],"NameLocal","Nivankyui",500,500,true]

];

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
private _vests = ["V_PlateCarrierH_CTRG", "V_PlateCarrier2_rgr_noflag_F", "V_PlateCarrierH_CTRG", "V_PlateCarrier2_wdl"];
private _helmets = ["H_HelmetSpecB_paint2", "H_HelmetB_Enh_tna_F", "H_HelmetSpecB_blk", "H_HelmetSpecB_wdl"];
private _hoods = ["G_Balaclava_combat", "G_Balaclava_TI_G_tna_F", "G_Balaclava_combat", "G_Balaclava_combat"];
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

btc_arsenal_loadout = [_uniforms, _vests, _helmets, _hoods, _laserdesignators, _night_visions, _weapons, _weapons_sniper, _weapons_machineGunner, _bipods, _pistols, _launcher_AT, _launcher_AA, _backpacks, _backpacks_big, [_radio, _radio, _radio, _radio]];
