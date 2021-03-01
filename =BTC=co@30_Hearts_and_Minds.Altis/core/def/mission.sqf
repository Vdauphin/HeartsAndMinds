
btc_version = [1, 21, 0];
diag_log format (["=BTC= HEARTS AND MINDS VERSION %1.%2.%3"] + btc_version);

//Param
//<< Time options >>
btc_p_time = "btc_p_time" call BIS_fnc_getParamValue;
btc_p_acctime = "btc_p_acctime" call BIS_fnc_getParamValue;
private _p_db = ("btc_p_load" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_auto_db = "btc_p_auto_db" call BIS_fnc_getParamValue isEqualTo 1;
btc_p_db_autoRestart = "btc_p_db_autoRestart" call BIS_fnc_getParamValue;
btc_p_db_autoRestartTime = "btc_p_db_autoRestartTime" call BIS_fnc_getParamValue;

//<< Respawn options >>
btc_p_respawn_location = "btc_p_respawn_location" call BIS_fnc_getParamValue;
btc_p_respawn_fromFOBToBase = ("btc_p_respawn_fromFOBToBase" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_rallypointTimer = "btc_p_rallypointTimer" call BIS_fnc_getParamValue;
btc_p_respawn_arsenal = ("btc_p_respawn_arsenal" call BIS_fnc_getParamValue) isEqualTo 1;

//<< Faction options >>
private _p_en = "btc_p_en" call BIS_fnc_getParamValue;
private _p_en_AA = ("btc_p_AA" call BIS_fnc_getParamValue) isEqualTo 1;
private _p_en_tank = ("btc_p_tank" call BIS_fnc_getParamValue) isEqualTo 1;
private _p_civ = "btc_p_civ" call BIS_fnc_getParamValue;
private _p_civ_veh = "btc_p_civ_veh" call BIS_fnc_getParamValue;

//<< IED options >>
btc_p_ied = ("btc_p_ied" call BIS_fnc_getParamValue)/2;
private _p_ied_spot = "btc_p_ied_spot" call BIS_fnc_getParamValue;
btc_p_ied_placement = "btc_p_ied_placement" call BIS_fnc_getParamValue;
btc_p_ied_drone = ("btc_p_ied_drone" call BIS_fnc_getParamValue) isEqualTo 1;

//<< Hideout/Cache options >>
private _hideout_n = "btc_p_hideout_n" call BIS_fnc_getParamValue;
private _cache_info_def = "btc_p_cache_info_def" call BIS_fnc_getParamValue;
private _cache_info_ratio = "btc_p_cache_info_ratio" call BIS_fnc_getParamValue;
private _info_chance = "btc_p_info_chance" call BIS_fnc_getParamValue;

//<< Skill options >>
btc_p_set_skill  = ("btc_p_set_skill" call BIS_fnc_getParamValue) isEqualTo 1;
private _p_skill = [
    ("btc_p_set_skill_general" call BIS_fnc_getParamValue)/10,//general
    ("btc_p_set_skill_aimingAccuracy" call BIS_fnc_getParamValue)/10,//aimingAccuracy
    ("btc_p_set_skill_aimingShake" call BIS_fnc_getParamValue)/10,//aimingShake
    ("btc_p_set_skill_aimingSpeed" call BIS_fnc_getParamValue)/10,//aimingSpeed
    ("btc_p_set_skill_endurance" call BIS_fnc_getParamValue)/10,//endurance
    ("btc_p_set_skill_spotDistance" call BIS_fnc_getParamValue)/10,//spotDistance
    ("btc_p_set_skill_spotTime" call BIS_fnc_getParamValue)/10,//spotTime
    ("btc_p_set_skill_courage" call BIS_fnc_getParamValue)/10,//courage
    ("btc_p_set_skill_reloadSpeed" call BIS_fnc_getParamValue)/10,//reloadSpeed
    ("btc_p_set_skill_commanding" call BIS_fnc_getParamValue)/10//commanding
];

//<< Spawn options >>
btc_p_is_free_prob = ("btc_p_is_free_prob" call BIS_fnc_getParamValue)/100;
btc_p_mil_group_ratio = ("btc_p_mil_group_ratio" call BIS_fnc_getParamValue)/100;
btc_p_mil_static_group_ratio = ("btc_p_mil_static_group_ratio" call BIS_fnc_getParamValue)/100;
btc_p_civ_group_ratio = ("btc_p_civ_group_ratio" call BIS_fnc_getParamValue)/100;
btc_p_animals_group_ratio = ("btc_p_animals_group_ratio" call BIS_fnc_getParamValue)/100;
private _wp_house_probability = ("btc_p_wp_house_probability" call BIS_fnc_getParamValue)/100;
btc_p_veh_armed_ho = ("btc_p_veh_armed_ho" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_veh_armed_spawn_more = ("btc_p_veh_armed_spawn_more" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_patrol_max = "btc_p_patrol_max" call BIS_fnc_getParamValue;
btc_p_civ_max_veh = "btc_p_civ_max_veh" call BIS_fnc_getParamValue;

//<< Gameplay options >>
btc_p_sea = ("btc_p_sea" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_chem = ("btc_p_chem" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_spect = ("btc_p_spect" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_side_mission_cycle = "btc_p_side_mission_cycle" call BIS_fnc_getParamValue;

//<< Arsenal options >>
btc_p_arsenal_Type = "btc_p_arsenal_Type" call BIS_fnc_getParamValue;
btc_p_arsenal_Restrict = "btc_p_arsenal_Restrict" call BIS_fnc_getParamValue;
btc_p_garage = ("btc_p_garage" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_autoloadout = "btc_p_autoloadout" call BIS_fnc_getParamValue;

//<< Other options >>
private _p_rep = "btc_p_rep" call BIS_fnc_getParamValue;
btc_p_rep_notify = ("btc_p_rep_notify" call BIS_fnc_getParamValue) isEqualTo 1;
private _p_city_radius = ("btc_p_city_radius" call BIS_fnc_getParamValue) * 100;
btc_p_trigger = if (("btc_p_trigger" call BIS_fnc_getParamValue) isEqualTo 1) then {
    "this && (false in (thisList apply {_x isKindOf 'Plane'})) && (false in (thisList apply {(_x isKindOf 'Helicopter') && (speed _x > 190)}))"
} else {
    "this"
};
btc_p_auto_headless = ("btc_p_auto_headless" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_debug = "btc_p_debug" call BIS_fnc_getParamValue;

switch (btc_p_debug) do {
    case 0 : {
        btc_debug_log = false;
        btc_debug = false;
    };
    case 1 : {
        btc_debug_log = true;
        btc_debug = true;
        btc_debug_graph = false;
        btc_debug_frames = 0;
    };
    case 2 : {
        btc_debug_log = true;
        btc_debug = false;
    };
};

if (!isMultiplayer) then {
    btc_debug_log = true;
    btc_debug = true;
    btc_debug_graph = false;
    btc_debug_frames = 0;
};

private _cfgVehicles = configFile >> "CfgVehicles";
private _allClassVehicles = ("true" configClasses _cfgVehicles) apply {configName _x};
private _allClassSorted = _allClassVehicles select {getNumber (_cfgVehicles >> _x >> "scope") isEqualTo 2};

if (isServer) then {
    btc_final_phase = false;
    btc_delay_createUnit = 0;

    //City
    btc_city_radius = _p_city_radius;
    btc_city_blacklist = [];//NAME FROM CFG

    //Civ
    btc_civ_veh_active = [];

    //Database
    btc_db_load = _p_db;
    btc_db_serverCommandPassword = "btc_password"; //Define the same password in server.cfg like this: serverCommandPassword = "btc_password";

    //Hideout
    btc_hideouts = [];
    btc_hideouts_id = 0;
    btc_hideouts_radius = 800;
    btc_hideout_n = _hideout_n;
    if (btc_hideout_n isEqualTo 99) then {
        btc_hideout_n = round random 5;
    };
    btc_hideout_safezone = 4000;
    btc_hideout_range = 3500;
    btc_hideout_cap_time = 1800;
    btc_hideout_cap_checking = false;
    btc_hideout_minRange = btc_hideout_range;

    //IED
    btc_ied_suic_time = 900;
    btc_ied_suic_spawned = - btc_ied_suic_time;
    btc_ied_offset = [0, -0.03, -0.07] select _p_ied_spot;
    btc_ied_list = [];

    //FOB
    btc_fobs = [[], [], []];
    btc_fob_rallypointTimer = 60 * btc_p_rallypointTimer;

    //MIL
    btc_p_mil_wp_ratios = [_wp_house_probability, (1 - _wp_house_probability) / 1.5 + _wp_house_probability];
    if ((btc_p_mil_wp_ratios select 0) isEqualTo (btc_p_mil_wp_ratios select 1)) then {
        btc_p_mil_wp_ratios set [1, 0.1 + (btc_p_mil_wp_ratios select 1)];
    };

    //Patrol
    btc_patrol_active = [];
    btc_patrol_area = 2500;

    //Rep
    btc_global_reputation = _p_rep;
    btc_rep_militia_call_time = 600;
    btc_rep_militia_called = - btc_rep_militia_call_time;
    btc_rep_delayed = [0, []];

    //Chem
    btc_chem_decontaminate = [btc_bigShower];
    btc_chem_contaminated = []; publicVariable "btc_chem_contaminated"; //Preserve reference

    //Spect
    btc_spect_emp = []; publicVariable "btc_spect_emp"; //Preserve reference

    //Cache
    btc_cache_type = [
        _allClassSorted select {
            _x isKindOf "ReammoBox_F" &&
            {getText(_cfgVehicles >> _x >> "model") isEqualTo "\A3\weapons_F\AmmoBoxes\AmmoBox_F"}
        },
        ["Land_PlasticCase_01_small_black_CBRN_F", "Land_PlasticCase_01_small_olive_CBRN_F", "Land_PlasticCase_01_small_CBRN_F"]
    ];
    private _weapons_usefull = "true" configClasses (configFile >> "CfgWeapons") select {
        getNumber (_x >> 'type') isEqualTo 1 &&
        {!(getArray (_x >> 'magazines') isEqualTo [])} &&
        {getNumber (_x >> 'scope') isEqualTo 2}
    };
    btc_cache_weapons_type = _weapons_usefull apply {configName _x};

    //Hideout classname
    btc_type_campfire = ["MetalBarrel_burning_F"] + (_allClassSorted select {_x isKindOf "Land_Campfire_F"});
    btc_type_Scrapyard = _allClassSorted select {
        _x isKindOf "Scrapyard_base_F" &&
        {!("scrap" in toLower _x)}
    };
    btc_type_bigbox = ["Box_FIA_Ammo_F", "Box_East_AmmoVeh_F", "CargoNet_01_box_F", "O_CargoNet_01_ammo_F"] + btc_type_Scrapyard;
    btc_type_seat = ["Land_WoodenLog_F", "Land_CampingChair_V2_F", "Land_CampingChair_V1_folded_F", "Land_CampingChair_V1_F"];
    btc_type_sleepingbag = _allClassSorted select {_x isKindOf "Land_Sleeping_bag_F"};
    btc_type_tent = ["Land_TentA_F", "Land_TentDome_F"] + (_allClassSorted select {
        _x isKindOf "Land_TentSolar_01_base_F" &&
        {!(_x isKindOf "Land_TentSolar_01_folded_base_F")}
    });
    btc_type_camonet = ["Land_IRMaskingCover_02_F"] + (_allClassSorted select {_x isKindOf "Shelter_base_F"});
    btc_type_satelliteAntenna = _allClassSorted select {_x isKindOf "Land_SatelliteAntenna_01_F"};

    //Side
    btc_side_ID = 0;
    btc_side_list = ["supply", "mines", "vehicle", "get_city", "tower", "civtreatment", "checkpoint", "convoy", "rescue", "capture_officer", "hostage", "hack", "kill", "EMP", "removeRubbish"]; // On ground (Side "convoy" and "capture_officer" are not design for map with different islands. Start and end city can be on different islands.)
    if (btc_p_sea) then {btc_side_list append ["civtreatment_boat", "underwater_generator"]}; // On sea
    if (btc_p_chem) then {btc_side_list pushBack "chemicalLeak"};
    btc_side_list_use = [];
    btc_type_tower = ["Land_Communication_F", "Land_TTowerBig_1_F", "Land_TTowerBig_2_F"];
    btc_type_phone = ["Land_PortableLongRangeRadio_F", "Land_MobilePhone_smart_F", "Land_MobilePhone_old_F"];
    btc_type_barrel = ["Land_GarbageBarrel_01_F", "Land_BarrelSand_grey_F", "MetalBarrel_burning_F", "Land_BarrelWater_F", "Land_MetalBarrel_F", "Land_MetalBarrel_empty_F"];
    btc_type_canister = ["Land_CanisterPlastic_F"];
    btc_type_pallet = ["Land_Pallets_stack_F", "Land_Pallets_F", "Land_Pallet_F"];
    btc_type_box = ["Box_East_Wps_F", "Box_East_WpsSpecial_F", "Box_East_Ammo_F"] + (btc_cache_type select 0);
    btc_type_generator = _allClassSorted select {_x isKindOf "Land_Device_assembled_F"};
    btc_type_storagebladder = _allClassSorted select {_x isKindOf "StorageBladder_base_F"};
    btc_type_mines = ["APERSMine", "APERSBoundingMine", "APERSTripMine"];
    btc_type_power = ["Land_PowerGenerator_F", "Land_PortableGenerator_01_F"] + (_allClassSorted select {_x isKindOf "Machine_base_F"});
    btc_type_cord = ["Land_ExtensionCord_F"];
    btc_type_cones = ["Land_RoadCone_01_F", "RoadCone_F", "RoadCone_L_F"];
    btc_type_fences = ["Land_PlasticNetFence_01_long_F", "Land_PlasticNetFence_01_long_d_F", "RoadBarrier_F", "TapeSign_F"];
    btc_type_barrier = ["Land_CncBarrier_stripes_F", "Land_CncBarrier_F"];
    btc_type_portable_light = _allClassSorted select {_x isKindOf "Land_PortableLight_single_F"};
    btc_type_portableLamp = _allClassSorted select {
        _x isKindOf "Land_PortableLight_02_base_F" ||
        {_x isKindOf "TentLamp_01_standing_base_F"}
    };
    btc_type_tentLamp = _allClassSorted select {_x isKindOf "TentLamp_01_base_F"};
    btc_type_first_aid_kits = ["Land_FirstAidKit_01_open_F", "Land_FirstAidKit_01_closed_F"];
    btc_type_body_bags = _allClassSorted select {
        _x isKindOf "Land_Bodybag_01_base_F" ||
        {_x isKindOf "Land_Bodybag_01_empty_base_F"} ||
        {_x isKindOf "Land_Bodybag_01_folded_base_F"}
    };
    btc_type_signs = _allClassSorted select {_x isKindOf "Land_Sign_Mines_F"};
    btc_type_bloods = _allClassSorted select {_x isKindOf "Blood_01_Base_F"};
    btc_type_medicals = _allClassSorted select {_x isKindOf "MedicalGarbage_01_Base_F"};
    btc_type_table = _allClassSorted select {_x isKindOf "Land_CampingTable_F"};
    btc_type_garbage = ["Land_Garbage_line_F","Land_Garbage_square3_F","Land_Garbage_square5_F"];
    btc_type_foodSack = _allClassSorted select {_x isKindOf "Land_FoodSack_01_empty_base_F"};
    btc_type_PaperBox = _allClassSorted select {
        _x isKindOf "Land_PaperBox_01_small_ransacked_base_F" ||
        {_x isKindOf "Land_PaperBox_01_small_open_base_F"} ||
        {_x isKindOf "Land_PaperBox_01_small_destroyed_base_F"}
    };
    btc_type_EmergencyBlanket = _allClassSorted select {_x isKindOf "Land_EmergencyBlanket_01_base_F"};
    btc_type_Sponsor = _allClassSorted select {
        _x isKindOf "SignAd_Sponsor_F" &&
        {"idap" in toLower _x}
    };
    btc_type_PlasticCase = _allClassSorted select {_x isKindOf "PlasticCase_01_base_F"};
    btc_type_MedicalTent = _allClassSorted select {_x isKindOf "Land_MedicalTent_01_base_F"};
    btc_type_cargo_ruins = _allClassSorted select {
        _x isKindOf "Ruins_F" &&
        {
            "cargo40" in toLower _x ||
            "cargo20" in toLower _x
        }
    };
    btc_type_spill = ["Oil_Spill_F", "Land_DirtPatch_01_6x8_F"] + (_allClassSorted select {
        _x isKindOf "Land_DirtPatch_02_base_F" ||
        {_x isKindOf "WaterSpill_01_Base_F"}
    });
    btc_type_tarp = _allClassSorted select {_x isKindOf "Tarp_01_base_F"};
    btc_type_SCBA = _allClassSorted select {_x isKindOf "SCBACylinder_01_base_F"};
    btc_type_brush = _allClassSorted select {_x isKindOf "Brush_01_base_F"};
    btc_type_broom = _allClassSorted select {_x isKindOf "Broom_01_base_F"};
    btc_type_sponge = _allClassSorted select {_x isKindOf "Sponge_01_base_F"};
    btc_type_connectorTentClosed = _allClassSorted select {_x isKindOf "Land_ConnectorTent_01_closed_base_F"};
    btc_type_crossTent = _allClassSorted select {_x isKindOf "Land_ConnectorTent_01_cross_base_F"};
    btc_type_connectorTent = (_allClassSorted select {_x isKindOf "Land_ConnectorTent_01_base_F"}) - btc_type_connectorTentClosed - btc_type_crossTent;
    btc_type_cargoEMP = _allClassSorted select {_x isKindOf "Cargo_EMP_base_F"};
    btc_type_antenna = _allClassSorted select {_x isKindOf "OmniDirectionalAntenna_01_base_F"};
    btc_type_solarPanel = _allClassSorted select {_x isKindOf "Land_SolarPanel_04_base_F"};

    //BTC Vehicles in missions.sqm
    btc_vehicles = [btc_veh_1, btc_veh_2, btc_veh_3, btc_veh_4, btc_veh_5, btc_veh_6, btc_veh_7, btc_veh_8, btc_veh_9, btc_veh_10, btc_veh_11, btc_veh_12, btc_veh_13, btc_veh_14, btc_veh_15, btc_veh_16, btc_veh_17, btc_veh_18];
    btc_helo = [btc_helo_1];

    // The two arrays below are prefixes of buildings and their multiplier.
    // They will multiply the values of btc_rep_malus_building_destroyed and btc_rep_malus_building_damaged,
    // if a building is not present here it will be multiplied by 1.0.
    // Use 0.0 to disable reputation hit on a specific's building destruction.
    // You can modify this for any other terrain, clearing the table will also make all buildings just have a 1.0 multiplier.
    // If there's a hit in btc_buildings_multiplier, btc_buildings_categories_multipliers will NOT be run
    btc_buildings_multipliers = [
        // Specific buildings that need to have a custom modifier.
        ["Land_BellTower", 0.2 ], ["Land_WIP", 1.5], ["Land_u_Addon_01", 0.2],
        ["Land_Airport_Tower", 10.0], ["Land_Mil_ControlTower", 10.0],
        ["Land_TentHangar", 7.0], ["Land_i_Shed_Ind", 1.5], ["Land_u_Shed_Ind", 1.5],
        ["Land_TTowerBig", 6.0], ["Land_TTowerSmall", 4.5], ["Land_cmp_Tower", 4.0]
    ];

    // The multipliers are applied on top of each other, so "Chapel" and "Small" will both multiply the malus value
    btc_buildings_categories_multipliers = [
        ["Shed", 0.75], ["Slum", 0.8], ["Small", 0.8], ["Big", 1.5], ["Villa", 2.0], ["Main", 3.0], ["Tower", 2.0],
        ["HouseBlock", 2.0], ["Panelak", 2.0], ["Tenement", 7.0],
        ["Barn", 1.5], ["School", 3.0], ["Office", 2.0], ["Shop", 1.5], ["Store", 1.5], ["Hospital", 12.0],
        ["Castle", 2.5], ["Chapel", 3.0], ["Minaret", 3.0], ["Mosque", 4.0], ["Church", 4.0], ["Kostel", 4.0],
        ["Lighthouse", 4.0],
        ["Airport", 4.0], ["Hangar", 1.75], ["ControlTower", 2.25], ["Terminal", 3.0],
        ["Hopper", 2.0], ["Tank", 4.0], ["Factory", 2.0], ["Transformer", 1.1],
        ["FuelStation", 5.0],
        ["Barracks", 1.75],
        ["spp", 3.0], ["Powerstation", 3.0],
        ["Pump", 2.5]
    ];
    btc_buildings_changed = [];

    //TAGS
    btc_type_tags = ["Land_Graffiti_01_F", "Land_Graffiti_02_F", "Land_Graffiti_03_F", "Land_Graffiti_04_F", "Land_Graffiti_05_F"];
    btc_type_tags_sentences = [
        "STR_BTC_HAM_TAG_GO",
        "STR_BTC_HAM_TAG_LN",
        "STR_BTC_HAM_TAG_WWKY",
        "STR_BTC_HAM_TAG_BA",
        "STR_BTC_HAM_TAG_GH",
        "STR_BTC_HAM_TAG_IE",
        "STR_BTC_HAM_TAG_DWY",
        "STR_BTC_HAM_TAG_WHY",
        "STR_BTC_HAM_TAG_YGD"
    ];
    btc_tags_player = [];
    btc_tags_server = [];

    //IED
    private _ieds = ["Land_GarbageContainer_closed_F", "Land_GarbageContainer_open_F", "Land_Portable_generator_F", "Land_WoodenBox_F", "Land_BarrelTrash_grey_F", "Land_Sacks_heap_F", "Land_Wreck_Skodovka_F", "Land_WheelieBin_01_F", "Land_GarbageBin_03_F"] + btc_type_pallet + btc_type_barrel + (_allClassSorted select {
        _x isKindOf "GasTank_base_F" ||
        {_x isKindOf "Garbage_base_F"} ||
        (_x isKindOf "Constructions_base_F" &&
        {
            "bricks" in toLower _x
        }) ||
        (_x isKindOf "Wreck_base_F" &&
        {
            "car" in toLower _x ||
            "offroad" in toLower _x
        })
    });
    btc_type_ieds = _ieds - ["Land_Garbage_line_F","Land_Garbage_square3_F","Land_Garbage_square5_F"];
    btc_model_ieds = btc_type_ieds apply {(toLower getText(_cfgVehicles >> _x >> "model")) select [1]};
    btc_type_blacklist = btc_type_tags + ["UserTexture1m_F"]; publicVariable "btc_type_blacklist";

    btc_groundWeaponHolder = [];
};

//Civ
// Get all faction from mod there are currently running
//copyToClipboard str (["CIV"] call btc_fnc_get_class);
private _allfaction = ["AFGCIV","CIV_F","DEFAULT","CFP_C_AFG","CFP_C_AFRCHRISTIAN","CFP_C_AFRISLAMIC","CFP_C_ASIA","CFP_C_CHERNO_WIN","CFP_C_MALDEN","CFP_C_ME","CUP_C_RU","CUP_C_CHERNARUS","CUP_C_SAHRANI","CUP_C_TK","GM_FC_GC_CIV","GM_FC_GE_CIV","LIB_CIV","LOP_AFR_CIV","LOP_CHR_CIV","LOP_TAK_CIV","CIV_IDAP_F","OPTRE_UEG_CIV","RDS_RUS_CIV","UK3CB_ADC_C","UK3CB_CHC_C","UK3CB_TKC_C","UNSUNG_C"]; //All factions
_p_civ = _allfaction select _p_civ; //Select faction selected from mission parameter
_p_civ_veh = _allfaction select _p_civ_veh; //Select faction selected from mission parameter
private _allclasse = [[_p_civ]] call btc_fnc_civ_class; //Create classes from factions, you can combine factions from the SAME side : [[_p_civ, "btc_ac","LOP_TAK_CIV"]] call btc_fnc_civ_class.

//Save class name to global variable
btc_civ_type_units = _allclasse select 0;
_allclasse = [[_p_civ_veh]] call btc_fnc_civ_class;
btc_civ_type_veh = _allclasse select 2;
btc_civ_type_boats = _allclasse select 1;

btc_w_civs = [
    ["srifle_DMR_06_hunter_F", "sgun_HunterShotgun_01_F", "srifle_DMR_06_hunter_khs_F", "sgun_HunterShotgun_01_Sawedoff_F", "Hgun_PDW2000_F", "arifle_AKM_F", "arifle_AKS_F"],
    ["hgun_Pistol_heavy_02_F", "hgun_Rook40_F", "hgun_Pistol_01_F"]
];
btc_g_civs = ["HandGrenade", "MiniGrenade", "ACE_M84", "ACE_M84"];

// ANIMALS
btc_animals_type = ["Hen_random_F", "Cock_random_F", "Fin_random_F", "Alsatian_Random_F", "Goat_random_F", "Sheep_random_F"];

//FOB
btc_fob_mat = "Land_Cargo20_blue_F";
btc_fob_structure = "Land_Cargo_HQ_V1_F";
btc_fob_flag = "Flag_NATO_F";
btc_fob_id = 0;
btc_fob_minDistance = 1500;

//IED
btc_type_ieds_ace = ["IEDLandBig_F", "IEDLandSmall_F"];
btc_ied_deleteOn = -1;

//Int
btc_int_radius_orders = 25;
btc_int_search_intel_time = 4;

//Info
btc_info_intel_chance = _info_chance;
btc_info_intel_type = [80, 95];//cache - hd - both
btc_info_cache_def = _cache_info_def;
btc_info_cache_ratio = _cache_info_ratio;
btc_info_hideout_radius = 4000;

//Supplies
btc_supplies_cargo = "Land_Cargo20_IDAP_F";
btc_supplies_mat = [
    _allClassSorted select {_x isKindOf "Land_FoodSack_01_cargo_base_F"},
    _allClassSorted select {_x isKindOf "Land_WaterBottle_01_stack_F"}
];

//Hazmat
btc_type_hazmat = ["HazmatBag_01_F", "Land_MetalBarrel_F"] + (_allClassSorted select {
    _x isKindOf "Land_GarbageBarrel_02_base_F" ||
    {_x isKindOf "Land_FoodContainer_01_F"} ||
    {_x isKindOf "Land_CanisterFuel_F"} ||
    {_x isKindOf "CBRNContainer_01_base_F"} ||
    {_x isKindOf "PlasticCase_01_base_F"}
});

//Containers
btc_containers_mat = ["Land_Cargo20_military_green_F", "Land_Cargo40_military_green_F"];

if (isServer) then {
    //Player
    missionNamespace setVariable ["btc_player_side", west, true];
    missionNamespace setVariable ["btc_respawn_marker", "respawn_west", true];

    //Log
    private _rearming_static =
    [
        //"Static"
    ] + (_allClassSorted select {(
        _x isKindOf "GMG_TriPod" ||
        {_x isKindOf "StaticMortar"} ||
        {_x isKindOf "HMG_01_base_F"} ||
        {_x isKindOf "AA_01_base_F"} ||
        {_x isKindOf "AT_01_base_F"}) && {
            getNumber (_cfgVehicles >> _x >> "side") isEqualTo ([east, west, independent, civilian] find btc_player_side)
        }
    });
    ([_rearming_static] call btc_fnc_find_veh_with_turret) params ["_rearming_static", "_magazines_static"];

    ([btc_vehicles + btc_helo] call btc_fnc_log_getRearmMagazines) params ["_rearming_vehicles", "_rearming_magazines"];

    btc_construction_array =
    [
        [
            "Fortifications",
            "Static",
            "Ammobox",
            "Containers",
            "Supplies",
            "FOB",
            "Decontamination",
            "Vehicle Logistic"
        ] + (_rearming_vehicles apply {getText (_cfgVehicles >> _x >> "displayName")}),
        [
            [
                //"Fortifications"
                "Land_BagBunker_Small_F",
                "Land_BagFence_Corner_F",
                "Land_BagFence_End_F",
                "Land_BagFence_Long_F",
                "Land_BagFence_Round_F",
                "Land_BagFence_Short_F",
                "Land_HBarrier_1_F",
                "Land_HBarrier_3_F",
                "Land_HBarrier_5_F",
                "Land_HBarrierBig_F",
                "Land_Razorwire_F",
                "Land_CncBarrier_F",
                "Land_CncBarrierMedium_F",
                "Land_CncBarrierMedium4_F",
                "Land_CncWall1_F",
                "Land_CncWall4_F",
                "Land_Mil_ConcreteWall_F",
                "Land_Mil_WallBig_4m_F",
                "Land_Mil_WallBig_Corner_F",
                "Land_PortableLight_double_F",
                "Land_Pod_Heli_Transport_04_medevac_black_F",
                "B_Slingload_01_Fuel_F"
            ],
            _rearming_static + _magazines_static,
            [
                //"Ammobox"
                "Land_WoodenBox_F"

            ] + (_allClassSorted select {
                _x isKindOf "ReammoBox_F" &&
                {!(_x isKindOf "Slingload_01_Base_F")} &&
                {!(_x isKindOf "Pod_Heli_Transport_04_base_F")}
            }),
            [
                //"Containers"

            ] + btc_containers_mat,
            [
                //"Supplies"
                btc_supplies_cargo
            ],
            [
                //"FOB"
                btc_fob_mat
            ],
            [
                //"Decontamination"
                "DeconShower_01_F"
            ],
            [
                //"Vehicle logistic"
                "ACE_Wheel",
                "ACE_Track"
            ]
        ] + _rearming_magazines
    ];
    publicVariable "btc_construction_array";
};

btc_supplies_mat params ["_food", "_water"];
private _c_array = btc_construction_array select 1;
btc_log_def_loadable = (_c_array select 0) + (_c_array select 1) + (_c_array select 2) + (_c_array select 3) + (_c_array select 4) + (_c_array select 5) + (_c_array select 6) + (_c_array select 7) + (_allClassVehicles select {_x isKindOf "ace_rearm_defaultCarriedObject"}) + _food + _water + btc_type_hazmat;
btc_log_def_can_load = (_c_array select 3);
btc_log_def_placeable = ((_c_array select 0) + (_c_array select 3) + (_c_array select 4) + (_c_array select 5) + (_c_array select 6) + _food + _water + btc_type_hazmat) select {
    getNumber(_cfgVehicles >> _x >> "ace_dragging_canCarry") isEqualTo 0
};
btc_tow_vehicleSelected = objNull;
btc_log_placing_max_h = 12;
btc_log_placing = false;
btc_log_obj_created = [];

btc_log_main_cc = [
    "Helicopter", 6,
    "Ship", 3,
    "Tank", 5,
    "Wheeled_APC", 5,
    "Truck", 10,
    "Truck_F", 10,
    "Motorcycle", 1,
    "Car", 3
];
btc_log_main_rc = [
    "Items_base_F", 2,
    "ReammoBox_F", 2,
    "thingX", 3,
    "StaticWeapon", 3,
    "Strategic", 2,
    "Motorcycle", 3,
    "Land_BarGate_F", 3,
    "HBarrier_base_F", 5,
    "Land_BagFence_Long_F", 3,
    "Wall_F", 5,
    "BagBunker_base_F", 5,
    "Wheeled_APC", 50,
    "Tank", 75,
    "Truck", 50,
    "Truck_F", 50,
    "Ship", 50,
    "Helicopter", 9999,
    "Car", 35,
    "Lamps_base_F", 2
];
btc_log_def_cc = [
    "Land_CargoBox_V1_F", 0,
    btc_supplies_cargo, 20,
    btc_fob_mat, 0,
    "Land_Cargo20_military_green_F", 20,
    "Land_Cargo40_military_green_F", 40
];
btc_log_def_rc = [
    "Land_BagBunker_Small_F", 5,
    "Land_CargoBox_V1_F", 9999,
    btc_supplies_cargo, 8,
    btc_fob_mat, 8,
    "Land_Cargo20_military_green_F", 8,
    "B_Slingload_01_Fuel_F", 20,
    "Land_Pod_Heli_Transport_04_medevac_black_F", 8
];

btc_fnc_log_get_nottowable = {
    params ["_tower"];

    switch (true) do {
        //The tower is a tank so it can't tow: plane and helicopter
        case (_tower isKindOf "Tank") : {["Plane", "Helicopter"];};
        case (_tower isKindOf "Truck_F") : {["Plane", "Helicopter"];};
        case (_tower isKindOf "Truck") : {["Plane", "Helicopter"];};
        case (_tower isKindOf "Ship") : {[];};
        //The tower is a car so it can't tow: truck, tank, plane and helicopter
        case (_tower isKindOf "Car") : {["Truck", "Truck_F", "Tank", "Plane", "Helicopter"];};
        default {["Car", "Truck", "Truck_F", "Tank", "Plane", "Helicopter", "Ship"];};
    };
};

//Lift
btc_fnc_lift_getLiftable = {
    params ["_chopper"];

    private _array   = [];
    switch (typeOf _chopper) do {
        case "B_SDV_01_F" : {
            _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car", "Truck", "Wheeled_APC_F", "Tracked_APC", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "Air", "Ship", "Tank"] + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);
        };
        default {
            private _MaxCargoMass = getNumber (configFile >> "CfgVehicles" >> typeOf _chopper >> "slingLoadMaxCargoMass");
            switch (true) do {
                case (_MaxCargoMass <= 510) : {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "Quadbike_01_base_F", "Strategic"];
                };
                case (_MaxCargoMass <= 2100) : {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car"];
                };
                case (_MaxCargoMass <= 4100) : {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car", "Truck_F", "Truck", "Wheeled_APC_F", "Air", "Ship"] + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);
                };
                case (_MaxCargoMass <= 14000) : {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car", "Truck_F", "Truck", "Wheeled_APC_F", "Tracked_APC", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "Air", "Ship", "Tank"] + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);
                };
                default {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car", "Truck_F", "Truck", "Wheeled_APC_F", "Tracked_APC", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "Air", "Ship", "Tank"] + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);
                };
            };
        };
    };
    _array
};

btc_ropes_deployed = false;
btc_lift_min_h  = 7;
btc_lift_max_h  = 12;
btc_lift_radius = 3;
btc_lift_HUD_x  = 0.874;
btc_lift_HUD_y  = 0.848;

//Mil
btc_hq = objNull;
// Get all faction from mod there are currently running
//copyToClipboard str (["EN"] call btc_fnc_get_class);
private _allfaction = ["BLU_G_F","IND_E_F","IND_F","IND_G_F","IND_L_F","OPF_F","OPF_G_F","TBAN","00VTN_MILFOR_USMCW","01VTN_MILFOR_USMCD","05VTN_MILFOR_TIASF","AFR_ARMY","ARA_ARMY","ARL_ARMY","BLU_F","CEC_ARMY","CFP_B_AFGPOLICE","CFP_B_CAF","CFP_B_CZARMY_WDL","CFP_B_ILIDF","CFP_B_IQARMY","CFP_B_IQPOLICE","CFP_B_KEARMY","CFP_B_MLARMY","CFP_B_NAARMY","CFP_B_PESH","CFP_B_UGARMY","CFP_B_USRANGERS_WDL","CFP_B_USSEALS_DES","CFP_B_USSEALS_WDL","CFP_B_YPG","CFP_I_ALNUSRA","CFP_I_IS","CFP_I_SDREBELS","CFP_I_SDREBELSRF","CFP_I_SSARMY","CFP_I_TUAREG","CFP_I_WESTULTRA","CFP_O_ABUSAYYAF","CFP_O_ALQAEDA","CFP_O_ALSHABAAB","CFP_O_ANSARALLAH","CFP_O_BOKOHARAM","CFP_O_CFREBELS","CFP_O_HAMAS","CFP_O_HEZBOLLAH","CFP_O_IQARMY","CFP_O_IRARMY","CFP_O_IS","CFP_O_SDARMY","CFP_O_SDMILITIA","CFP_O_SOREBEL","CFP_O_SSREBELS","CFP_O_SYARMY","CFP_O_TBAN","CUP_B_CDF","CUP_B_CZ","CUP_B_GB","CUP_B_HIL","CUP_B_RNZN","CUP_B_US_ARMY","CUP_B_USMC","CUP_I_NAPA","CUP_I_RACS","CUP_I_UN","CUP_O_CHDKZ","CUP_O_RU","CUP_O_SLA","CUP_O_TK","CUP_O_TK_MILITIA","CUP_STATIC_SHIPS","CFP_B_CDF_SNW","CFP_B_DEARMY_WDL","CFP_B_GBARMY_WDL","CFP_B_USARMY_1991_DES","CFP_B_USARMY_1991_WDL","CFP_B_USARMY_2003_DES","CFP_B_USARMY_2003_WDL","CFP_B_USCIA","CFP_B_USMC_DES","CFP_I_WAGNER","CFP_I_WAGNER_WDL","CFP_I_WAGNER_WIN","CFP_O_RUARMY_DES","CFP_O_RUMVD","CFP_O_WAGNER","CFP_O_WAGNER_WDL","CFP_O_WAGNER_WIN","CUP_B_GER","CUP_I_PMC_ION","CUP_I_TK_GUE","CFP_B_AFARMY","CFP_B_USARMY_WDL","CFP_O_CHDKZ_SNW","OPF_R_F","BLU_CTRG_F","BLU_GEN_F","BLU_T_F","CFP_O_NKARMY","OPF_GEN_F","FAP_ARMY","FOW_HEER","FOW_IJA_NAS","FOW_UK_FAA","FOW_USA_NAVY","FOW_WAFFENSS","FOW_AUS","FOW_HI","FOW_IJA","FOW_LUFTWAFFE","FOW_UK","FOW_USA","FOW_USA_P","FOW_USMC","GAL_ARMY","GANGBLUE_ARMY","GANGRED_ARMY","GM_FC_DK","GM_FC_GC","GM_FC_GC_BGS","GM_FC_GE","GM_FC_GE_BGS","GM_FC_PL","IBR_ZETABORN_FACTION","ISC_ALNUSRA_I","ISC_IP_B","ISC_IS_I","ISC_IS_O","ISC_PESH_B","ISC_YPG_B","LM_OPCAN_URA","LIB_ACI","LIB_ARR","LIB_DAK","LIB_FFI","LIB_FSJ","LIB_GUER","LIB_MKHL","LIB_NAC","LIB_NKVD","LIB_RAAF","LIB_RBAF","LIB_RKKA","LIB_RKKA_W","LIB_UK_AB","LIB_UK_AB_W","LIB_UK_ARMY","LIB_UK_ARMY_W","LIB_UK_DR","LIB_US_101AB","LIB_US_82AB","LIB_US_ARMY","LIB_US_ARMY_W","LIB_US_RANGERS","LIB_WEHRMACHT","LIB_WEHRMACHT_W","LM_OPCAN_CGC","LM_OPCAN_CMA","LM_OPCAN_CPD","LM_OPCAN_FRI","LM_OPCAN_FRI_DES","LM_OPCAN_FRI_WDL","LM_OPCAN_KOS","LM_OPCAN_SU","LM_OPCAN_UNSC_ARMY","LM_OPCAN_UNSC_ARMY_D","LM_OPCAN_UNSC_ARMY_MIX","LM_OPCAN_UNSC_ARMY_RES","LM_OPCAN_UNSC_MC","LM_OPCAN_UNSC_MC_CEA","LM_OPCAN_UNSC_MC_D","LM_OPCAN_UNSC_MC_INF","LOP_AA","LOP_AFR","LOP_AFR_OPF","LOP_AM","LOP_AM_OPF","LOP_BH","LOP_CDF","LOP_CHDKZ","LOP_GRE","LOP_IA","LOP_IRA","LOP_IRAN","LOP_ISTS","LOP_ISTS_OPF","LOP_NAPA","LOP_NK","LOP_PESH","LOP_PESH_IND","LOP_PMC","LOP_RACS","LOP_SLA","LOP_SYR","LOP_TKA","LOP_TRK","LOP_UA","LOP_UKR","LOP_UN","LOP_US","LOP_UVF","BLU_W_F","MOL_ARMY","O_CAR","OPF_T_F","OPTRE_FC_COVENANT","OPTRE_INS","OPTRE_PD","OPTRE_UNSC","ISC_IA_B","RHS_FACTION_MSV","RHS_FACTION_RVA","RHS_FACTION_TV","RHS_FACTION_VDV","RHS_FACTION_VMF","RHS_FACTION_VPVO","RHS_FACTION_VV","RHS_FACTION_VVS","RHS_FACTION_VVS_C","ISC_SAA_O","RHSGREF_FACTION_CDF_AIR","RHSGREF_FACTION_CDF_AIR_B","RHSGREF_FACTION_CHDKZ","RHSSAF_FACTION_AIRFORCE","RHSSAF_FACTION_AIRFORCE_OPFOR","RHSSAF_FACTION_ARMY","RHSSAF_FACTION_ARMY_OPFOR","RHSSAF_FACTION_UN","RHS_FACTION_SOCOM","RHS_FACTION_USAF","RHS_FACTION_USARMY_D","RHS_FACTION_USMC_D","RHS_FACTION_USN","RHSGREF_FACTION_CDF_GROUND","RHSGREF_FACTION_CDF_GROUND_B","RHSGREF_FACTION_NATIONALIST","RHSGREF_FACTION_TLA","RHSGREF_FACTION_TLA_G","RHSGREF_FACTION_UN","SG_STURM","SG_STURMPANZER","IND_C_F","RHS_FACTION_USARMY_WD","RHS_FACTION_USMC_WD","RHSGREF_FACTION_CDF_NG","RHSGREF_FACTION_CDF_NG_B","RHSGREF_FACTION_CHDKZ_G","RHSGREF_FACTION_HIDF","UK3CB_AAF_B","UK3CB_AAF_I","UK3CB_AAF_O","UK3CB_ADA_B","UK3CB_ADA_I","UK3CB_ADA_O","UK3CB_ADC_B","UK3CB_ADC_I","UK3CB_ADC_O","UK3CB_ADE_I","UK3CB_ADE_O","UK3CB_ADG_B","UK3CB_ADG_I","UK3CB_ADG_O","UK3CB_ADM_B","UK3CB_ADM_I","UK3CB_ADM_O","UK3CB_ADP_B","UK3CB_ADP_I","UK3CB_ADP_O","UK3CB_ADR_B","UK3CB_ADR_I","UK3CB_ADR_O","UK3CB_ANA_B","UK3CB_ANP_B","UK3CB_CCM_B","UK3CB_CCM_I","UK3CB_CCM_O","UK3CB_CHC_B","UK3CB_CHC_I","UK3CB_CHC_O","UK3CB_CHD_B","UK3CB_CHD_I","UK3CB_CHD_O","UK3CB_CPD_B","UK3CB_CPD_I","UK3CB_CPD_O","UK3CB_CW_SOV_O_EARLY","UK3CB_CW_SOV_O_LATE","UK3CB_CW_US_B_EARLY","UK3CB_CW_US_B_LATE","UK3CB_NAP_B","UK3CB_NAP_I","UK3CB_NAP_O","UK3CB_TKA_B","UK3CB_TKA_I","UK3CB_TKA_O","UK3CB_TKC_B","UK3CB_TKC_I","UK3CB_TKC_O","UK3CB_TKM_B","UK3CB_TKM_I","UK3CB_TKM_O","UK3CB_TKP_B","UK3CB_TKP_I","UK3CB_TKP_O","UK3CB_UN_B","UK3CB_UN_I","UNSUNG_AUS","UNSUNG_E","UNSUNG_EV","UNSUNG_G","UNSUNG_NZ","UNSUNG_ROK","UNSUNG_W","00VTN_MILFOR_MIW_EMR","00VTN_MILITIA_RU","01VTN_INSURGENTS_RU","01VTN_MILFOR_MIW","02VTN_MILFOR_RC","03VTN_INSURGENTS_ISIL","03VTN_MILFOR_SPPU","07VTN_MILFOR_TNG"]; //All factions
_p_en = _allfaction select _p_en; //Select faction selected from mission parameter
_allclasse = [[_p_en], _p_en_AA, _p_en_tank] call btc_fnc_mil_class; //Create classes from factions, you can combine factions like that: [[_p_en , "IND_F"], _p_en_AA, _p_en_tank] call btc_fnc_mil_class;

//Save class name to global variable
btc_enemy_side = _allclasse select 0;
btc_type_units = _allclasse select 1;
btc_type_divers = _allclasse select 2;
btc_type_crewmen = _allclasse select 3;
btc_type_boats = _allclasse select 4;
btc_type_motorized = _allclasse select 5;
btc_type_motorized_armed = _allclasse select 6;
btc_type_mg = _allclasse select 7;
btc_type_gl = _allclasse select 8;

//Sometimes you need to remove units: - ["Blabla","moreBlabla"];
//Sometimes you need to add units: + ["Blabla","moreBlabla"];
switch (_p_en) do {
    /*case "Myfactionexemple" : {
        btc_type_units = btc_type_units - ["Blabla","moreBlabla"];
        btc_type_divers = btc_type_divers + ["Blabla","moreBlabla"];
        btc_type_crewmen = "Blabla";
        btc_type_boats = btc_type_boats;
        btc_type_motorized = btc_type_motorized;
        btc_type_mg = btc_type_mg;
        btc_type_gl = btc_type_gl;
    };*/
    case "OPF_G_F" : {
        btc_type_motorized = btc_type_motorized + ["I_Truck_02_transport_F", "I_Truck_02_covered_F"];
        btc_type_motorized_armed = btc_type_motorized_armed + ["I_Heli_light_03_F"];
    };
    case "IND_C_F" : {
        btc_type_motorized = btc_type_motorized + ["I_G_Offroad_01_repair_F", "I_G_Offroad_01_F", "I_G_Quadbike_01_F", "I_G_Van_01_fuel_F", "I_Truck_02_transport_F", "I_Truck_02_covered_F"];
        btc_type_motorized_armed = btc_type_motorized_armed + ["I_Heli_light_03_F", "I_G_Offroad_01_F"];
        btc_type_units = btc_type_units - ["I_C_Soldier_Camo_F"];
    };
};

//Chem
btc_chem_range = 3;

//Spect
btc_spect_range = 1000;
btc_spect_updateOn = -1;

//Rep
btc_rep_bonus_cache = 100;
btc_rep_bonus_civ_hh = 3;
btc_rep_bonus_disarm = 15;
btc_rep_bonus_hideout = 200;
btc_rep_bonus_mil_killed = 0.25;
btc_rep_bonus_IEDCleanUp = 10;
btc_rep_bonus_removeTag = 3;
btc_rep_bonus_removeTagLetter = 0.5;

btc_rep_malus_civ_hd = - 2;
btc_rep_malus_animal_hd = - 1;
btc_rep_malus_civ_killed = - 10;
btc_rep_malus_animal_killed = - 5;
btc_rep_malus_civ_suppressed = - 4;
btc_rep_malus_player_respawn = - 10;
btc_rep_malus_veh_killed = - 25;
btc_rep_malus_building_damaged = - 2.5;
btc_rep_malus_building_destroyed = - 5;

//Skill
btc_AI_skill = _p_skill;

//Headless
btc_units_owners = [];

btc_player_type = ["SoldierWB", "SoldierEB", "SoldierGB"] select ([west, east, independent] find btc_player_side);
