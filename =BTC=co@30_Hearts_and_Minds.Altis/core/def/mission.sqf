
private ["_p_civ_veh","_p_db","_p_en","_hideout_n","_cache_info_def","_cache_info_ratio","_info_chance","_p_rep","_p_skill","_c_array","_tower","_array","_chopper","_p_civ","_btc_rearming_vehicles","_vehicles","_magazines","_p_city_radius","_magazines_static","_static","_btc_rearming_static","_magazines_clean","_weapons_usefull","_magazines_static_clean","_p_en_AA"];

btc_version = 1.16; diag_log format ["=BTC= HEARTS AND MINDS VERSION %1",(str(btc_version) + ".2")];

//Param

//<< Time options >>
btc_p_time = (paramsArray select 1);
btc_p_acctime = (paramsArray select 2);
_p_db = if ((paramsArray select 3) isEqualTo 0) then {false} else {true};
btc_p_auto_db = (paramsArray select 4);

//<< Faction options >>
_p_en = (paramsArray select 6);
_p_en_AA = false;
_p_en_tank = false;
_p_civ = (paramsArray select 7);
_p_civ_veh = (paramsArray select 8);

//<< IED options >>
btc_p_ied = (paramsArray select 10)/2;
ace_explosives_RequireSpecialist  = (paramsArray select 11) isEqualTo 0;

//<< Hideout/Cache options >>
_hideout_n = (paramsArray select 13);
_cache_info_def = (paramsArray select 14);
_cache_info_ratio = (paramsArray select 15);
_info_chance = (paramsArray select 16);

//<< Medical options >>
btc_p_redeploy = if ((paramsArray select 18) isEqualTo 0) then {false} else {true};
ace_medical_level = paramsArray select 19;
ace_medical_enableAdvancedWounds = if ((paramsArray select 20) isEqualTo 0) then {false} else {true};
ace_medical_maxReviveTime = paramsArray select 21;

//<< Skill options >>
btc_p_set_skill  = if ((paramsArray select 23) isEqualTo 0) then {false} else {true};
_p_skill = [
	(paramsArray select 24)/10,//general
	(paramsArray select 25)/10,//aimingAccuracy
    (paramsArray select 26)/10,//aimingShake
    (paramsArray select 27)/10,//aimingSpeed
    (paramsArray select 28)/10,//endurance
    (paramsArray select 29)/10,//spotDistance
    (paramsArray select 30)/10,//spotTime
    (paramsArray select 31)/10,//courage
    (paramsArray select 32)/10,//reloadSpeed
    (paramsArray select 33)/10//commanding
];

//<< Other options >>
_p_rep = (paramsArray select 35);
ace_rearm_level = (paramsArray select 36);
btc_p_sea  = if ((paramsArray select 37) isEqualTo 0) then {false} else {true};
_p_city_radius = (paramsArray select 38) * 100;
btc_p_trigger = if (false) then {"this && !btc_db_is_saving && (false in (thisList apply {_x isKindOf 'Plane'})) && (false in (thisList apply {(_x isKindOf 'Helicopter') && (speed _x > 190)}))"} else {"this && !btc_db_is_saving"};
btc_p_side_mission_cycle = false;
btc_p_garage = false;
btc_p_debug  = (paramsArray select 39);

//OPTION must be use for H&M
if (ace_medical_maxReviveTime > 0) then {ace_medical_enableRevive = 1;ace_medical_preventInstaDeath = true};
ace_medical_enableFor = 1;
ace_cargo_enable = true;

//btc_acre_mod = isClass(configFile >> "cfgPatches" >> "acre_main");
//btc_tfr_mod = isClass(configFile >> "cfgPatches" >> "task_force_radio");

switch (btc_p_debug) do {
	case 0 : {btc_debug_log = false;btc_debug = false;};
	case 1 : {btc_debug_log = true;btc_debug = true;};
	case 2 : {btc_debug_log = true;btc_debug = false;};
};

if (!isMultiplayer) then {btc_debug_log = true;btc_debug = true;};

if (isServer) then {
	btc_final_phase = false;

	//City
	btc_city_radius = _p_city_radius;
	btc_city_blacklist = [];//NAME FROM CFG

	//Civ
	btc_civ_veh_active = [];

	//Database
	btc_db_is_saving = false;
	btc_db_load = _p_db;

	//Hideout
	btc_hideouts = [];
	btc_hideouts_id = 0;
	btc_hideouts_radius = 400;
	btc_hideout_n = _hideout_n;
	if (btc_hideout_n == 99) then {
		btc_hideout_n = (round random 5);
	};
	btc_hideout_safezone = 4000;
	btc_hideout_range = 3500;
	btc_hideout_rinf_time = 600;
	btc_hideout_cap_time = 1800;
	btc_hideout_cap_checking = false;

	//IED
	btc_ied_suic_time = 900;
	btc_ied_suic_spawned = - btc_ied_suic_time;

	//FOB
	btc_fobs = [[],[]];


	//Log
	btc_log_id_repo = 10;
	btc_log_cargo_repo = "Land_HBarrierBig_F" createVehicle [- 5000,- 5000,0];

	//Patrol
	btc_patrol_max = 8;
	btc_patrol_active = [];
	btc_patrol_area = 2500;

	//Rep
	btc_global_reputation = _p_rep;
	btc_rep_militia_call_time = 600;
	btc_rep_militia_called = - btc_rep_militia_call_time;

	//Hideout classname
	btc_type_campfire = ["MetalBarrel_burning_F","Campfire_burning_F","Land_Campfire_F","FirePlace_burning_F"];
	btc_type_bigbox = ["Box_FIA_Ammo_F","Box_East_AmmoVeh_F","CargoNet_01_box_F","O_CargoNet_01_ammo_F","Land_Pallet_MilBoxes_F","Land_PaperBox_open_full_F"];
	btc_type_seat = ["Land_WoodenLog_F","Land_CampingChair_V2_F","Land_CampingChair_V1_folded_F","Land_CampingChair_V1_F"];
	btc_type_sleepingbag = ["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
	btc_type_tent = ["Land_TentA_F","Land_TentDome_F"];
	btc_type_camonet = ["CamoNet_ghex_big_F","CamoNet_OPFOR_big_F","CamoNet_INDP_big_F","CamoNet_BLUFOR_big_F","CamoNet_OPFOR_open_F","CamoNet_ghex_open_F","CamoNet_BLUFOR_open_F","Land_IRMaskingCover_02_F","CamoNet_BLUFOR_F","CamoNet_ghex_F","CamoNet_OPFOR_F","CamoNet_INDP_F"];

	//Side
	btc_side_aborted = false;
	btc_side_assigned = false;
	btc_side_done = false;
	btc_side_failed = false;
	//Side 9 and 11 are not think for map with different islands. Start and end city can be on different islands.
	btc_side_list = if (btc_p_sea) then {[0,1,2,3,4,5,6,7,8,9,10,11,12]} else {[0,1,2,3,4,5,6,9,10,11,12]};
	btc_side_list_use = + btc_side_list;
	btc_side_jip_data = [];
	btc_type_tower = ["Land_Communication_F","Land_TTowerBig_1_F","Land_TTowerBig_2_F"];
	btc_type_phone = ["Land_PortableLongRangeRadio_F","Land_MobilePhone_smart_F","Land_MobilePhone_old_F"];
	btc_type_barrel = ["Land_GarbageBarrel_01_F","Land_BarrelSand_grey_F","MetalBarrel_burning_F","Land_BarrelWater_F","Land_MetalBarrel_F","Land_MetalBarrel_empty_F"];
	btc_type_canister = ["Land_CanisterPlastic_F"];
	btc_type_pallet = ["Land_Pallets_stack_F","Land_Pallets_F","Land_Pallet_F"];
	btc_type_box = ["Box_East_Wps_F","Box_East_WpsSpecial_F","Box_East_Ammo_F"];
	btc_type_generator = ["Land_Device_assembled_F","Land_Device_disassembled_F"];
	btc_type_storagebladder = ["StorageBladder_02_water_forest_F","StorageBladder_02_water_sand_F"];
	btc_type_mines = ["APERSMine","APERSBoundingMine","APERSTripMine"];
	btc_type_power = ["WaterPump_01_sand_F","WaterPump_01_forest_F","Land_PressureWasher_01_F","Land_DieselGroundPowerUnit_01_F","Land_JetEngineStarter_01_F","Land_PowerGenerator_F","Land_PortableGenerator_01_F"];
	btc_type_cord = ["Land_ExtensionCord_F"];

	//Vehs
	btc_vehicles = [btc_veh_1,btc_veh_2,btc_veh_3,btc_veh_4,btc_veh_5,btc_veh_6,btc_veh_7,btc_veh_8,btc_veh_9,btc_veh_10,btc_veh_11,btc_veh_12,btc_veh_13,btc_veh_14,btc_veh_15];
	btc_helo = [btc_helo_1];
};

//City
btc_city_type = "Land_Ammobox_rounds_F";

//Civ
// Get all faction from mod there are currently running
//copyToClipboard str (["CIV"] call btc_fnc_get_class);
private _allfaction = ["AFGCIV","CIV_F","BTC_AC","CAF_AG_AFR_CIV","CAF_AG_ME_CIV","CUP_C_CHERNARUS","CUP_C_RU","CUP_C_TK","LIB_CIV","LOP_AFR_CIV","LOP_CHR_CIV","LOP_TAK_CIV","OPTRE_UEG_CIV","RDS_RUS_CIV","UNSUNG_C"]; //All factions
_p_civ = _allfaction select _p_civ;	//Select faction selected from mission parameter
_p_civ_veh = _allfaction select _p_civ_veh;	//Select faction selected from mission parameter
private _allclasse = [[_p_civ]] call btc_fnc_civ_class; //Create classes from the corresponding factions [_p_civ , "btc_ac"], can combine factions from the SAME side.

//Save class name to global variable
btc_civ_type_units = _allclasse select 0;
_allclasse = [[_p_civ_veh]] call btc_fnc_civ_class;
btc_civ_type_veh = _allclasse select 2;
btc_civ_type_boats = _allclasse select 1;

btc_civ_max_veh = 10;
btc_w_civs = ["V_Rangemaster_belt","arifle_Mk20_F","30Rnd_556x45_Stanag","hgun_ACPC2_F","9Rnd_45ACP_Mag"];

//Cache
btc_cache_type = ["Box_East_Ammo_F"];
_weapons_usefull = "true" configClasses (configfile >> "CfgWeapons") select {(getnumber (_x >> 'type') isEqualTo 1) AND !(getarray(_x >> 'magazines') isEqualTo []) AND (getNumber (_x >> 'scope') isEqualTo 2)};
btc_cache_weapons_type = _weapons_usefull apply {configName _x};

//FOB
btc_fob_mat = "Land_Cargo20_blue_F";
btc_fob_structure = "Land_Cargo_HQ_V1_F";
btc_fob_flag = "Flag_NATO_F";
btc_fob_id = 0;

//IED
btc_type_ieds = ["Land_GarbageContainer_closed_F","Land_GarbageContainer_open_F","Land_GarbageBarrel_01_F","Land_Pallets_F","Land_Portable_generator_F","Land_WoodenBox_F","Land_MetalBarrel_F","Land_BarrelTrash_grey_F","Land_Sacks_heap_F","Land_Bricks_V2_F","Land_Bricks_V3_F","Land_Bricks_V4_F","Land_GarbageBags_F","Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_JunkPile_F","Land_Tyres_F","Land_Wreck_Skodovka_F","Land_Wreck_Car_F","Land_Wreck_Car3_F","Land_Wreck_Car2_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_WheelieBin_01_F","Land_GarbageHeap_04_F","Land_GarbageHeap_03_F","Land_GarbageHeap_01_F"];
btc_model_ieds = btc_type_ieds apply {(toLower gettext(configfile >> "CfgVehicles" >> _x >> "model")) select [1]};
btc_type_ieds_ace = ["IEDLandBig_F","IEDLandSmall_F"];

//Int
btc_int_radius_orders = 25;
btc_int_search_intel_time = 4;

//Info
btc_info_intel_chance = _info_chance;
btc_info_intel_type = [80,95];//cache - hd - both
btc_info_cache_def = _cache_info_def;
btc_info_cache_ratio = _cache_info_ratio;
btc_info_hideout_radius = 4000;

//Supplies
btc_supplies_mat = "Land_Cargo20_red_F";

//Log
if (isServer) then {
	#define	REARM_TURRET_PATHS  [[-1], [0], [0,0], [0,1], [1], [2], [0,2]]

	_btc_rearming_vehicles = [];
	{
		if (count (configFile >> "CfgVehicles" >> typeOf _x >> "Turrets") > 0) then {
			_btc_rearming_vehicles pushBackUnique typeOf _x;
		};
	} forEach (btc_vehicles + btc_helo);

	_btc_rearming_static =
	[
		//"Static"
		"B_static_AT_F",
		"B_static_AA_F",
		"B_GMG_01_A_F",
		"B_GMG_01_high_F",
		"B_GMG_01_F",
		"B_HMG_01_A_F",
		"B_HMG_01_high_F",
		"B_HMG_01_F",
		"B_Mortar_01_F"
	];

	_magazines_static = [];
	{
		_static = _x;
		{
			_magazines_static append (([_static,_x] call btc_fnc_log_getconfigmagazines));
		} forEach REARM_TURRET_PATHS;
	} forEach _btc_rearming_static;
	_magazines_static = _magazines_static - ["FakeWeapon"];
	_magazines_static_clean = [];
	{
		_magazines_static_clean pushBackUnique _x;
	} forEach _magazines_static;

	btc_construction_array =
	[
		[
			"Fortifications",
			"Static",
			"Ammobox",
			"Containers",
			"Supplies",
			"FOB",
			"Vehicle Logistic"
		] + (_btc_rearming_vehicles apply {getText (configFile >> "cfgVehicles" >> _x >> "displayName")}),
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
				"Land_PortableLight_double_F"
			],
			_btc_rearming_static + _magazines_static_clean,
			[
				//"Ammobox"
				"rhsusf_mags_crate",
				"Box_NATO_Ammo_F",
				"Box_NATO_Support_F",
				"ACE_medicalSupplyCrate_advanced",
				"ACE_medicalSupplyCrate",
				"B_supplyCrate_F",
				"B_CargoNet_01_ammo_F"
			],
			[
				//"Containers"
				"Land_Cargo20_military_green_F",
				"Land_Cargo40_military_green_F"

			],
			[
				//"Supplies"
				btc_supplies_mat
			],
			[
				//"FOB"
				btc_fob_mat
			],
			[
				//"Vehicle logistic"
				"ACE_Wheel",
				"ACE_Track"
			]
		] + (_btc_rearming_vehicles apply {
				_vehicles = _x;
				_magazines = [];
				{
					_magazines append (([_vehicles,_x] call btc_fnc_log_getconfigmagazines));
				} forEach REARM_TURRET_PATHS;
				_magazines_clean = [];
				{
					_magazines_clean pushBackUnique _x;
				} forEach _magazines;
				_magazines_clean
			})
	];
	publicVariable "btc_construction_array";
};

_c_array = btc_construction_array select 1;
btc_log_def_draggable = (_c_array select 1) + (_c_array select 2);
btc_log_def_loadable = (_c_array select 0) + (_c_array select 1) + (_c_array select 2) + (_c_array select 3) + (_c_array select 4) + (_c_array select 5) + (_c_array select 6) + (["ace_rearm_defaultCarriedObject", "ace_rearm_Bo_Mk82","ace_rearm_Bomb_04_F","ace_rearm_Bo_GBU12_LGB","ace_rearm_Bomb_03_F","ace_rearm_Missile_AA_03_F","ace_rearm_Missile_AGM_02_F","ace_rearm_Missile_AGM_01_F","ace_rearm_Rocket_03_AP_F","ace_rearm_R_80mm_HE","ace_rearm_R_60mm_HE","ace_rearm_Rocket_04_HE_F","ace_rearm_R_Hydra_HE","ace_rearm_Missile_AA_04_F","ace_rearm_M_PG_AT","ace_rearm_R_230mm_HE","ace_rearm_Rocket_03_HE_F","ace_rearm_Rocket_04_AP_F","ace_rearm_R_230mm_fly"]);
btc_log_def_can_load = (_c_array select 3);
btc_log_def_placeable = (_c_array select 0) + (_c_array select 3) + (_c_array select 4) + (_c_array select 5);
btc_log_max_distance_load = 15;
btc_log_object_selected = objNull;
btc_log_vehicle_selected = objNull;
btc_log_placing_max_h = 12;
btc_log_placing = false;
btc_log_obj_created = [];

btc_log_main_cc =
[
	"Helicopter",6,
	"Ship",3,
	"Tank",5,
	"Wheeled_APC",5,
	"Truck",10,
	"Truck_F",10,
	"Motorcycle",1,
	"Car",3
];
btc_log_main_rc =
[
	"ReammoBox_F",2,
	"thingX",3,
	"StaticWeapon",3,
	"Strategic",2,
	"Motorcycle",3,
	"Land_BarGate_F",3,
	"HBarrier_base_F",5,
	"Land_BagFence_Long_F",3,
	"Wall_F",5,
	"BagBunker_base_F",5,
	"Wheeled_APC",50,
	"Tank",75,
	"Truck",50,
	"Truck_F",50,
	"Ship",50,
	"Helicopter",9999,
	"Car",35
];
btc_log_def_cc =
[
	"B_Quadbike_01_F",2,
	"B_UGV_01_rcws_F",4,
	"B_UGV_01_F",4,
	"Land_CargoBox_V1_F",0,
	btc_supplies_mat,0,
	btc_fob_mat,0,
	"Land_Cargo20_military_green_F",20,
	"Land_Cargo40_military_green_F",40,
	//Trucks
	"B_Truck_01_transport_F",10,
	"B_Truck_01_covered_F",10,
	"I_Truck_02_covered_F",10,
	"O_Truck_02_covered_F",10,
	"I_Truck_02_transport_F",10,
	"O_Truck_02_transport_F",10,
	"O_Truck_02_transport_F",10
];
btc_log_def_rc =
[
	"Land_BagBunker_Small_F",5,
	"Land_CargoBox_V1_F",9999,
	btc_supplies_mat,10,
	btc_fob_mat,10,
	"Land_Cargo20_military_green_F",20,
	"Land_Cargo40_military_green_F",40
];

btc_fnc_log_get_nottowable = {
	//Return array of objects not towable by "car".
	_tower = _this select 0;
	switch (true) do {
		case (_tower isKindOf "Tank") : {_array = ["Plane","Helicopter"];};
		case (_tower isKindOf "Truck_F") : {_array = ["Plane","Helicopter"];};
		case (_tower isKindOf "Truck") : {_array = ["Plane","Helicopter"];};
		case (_tower isKindOf "Ship") : {_array = ["Car","Truck","Truck_F","Tank","Plane","Helicopter"];};
		case (_tower isKindOf "Car") : {_array = ["Truck","Truck_F","Tank","Plane","Helicopter"];};
		default {_array   = ["Car","Truck","Truck_F","Tank","Plane","Helicopter","Ship"];};
	};
	_array
};

//Lift
btc_fnc_log_get_liftable = {
	_chopper = _this select 0;
	_array   = [];
	switch (typeOf _chopper) do	{
		//MH9
		case "B_Heli_Light_01_F"     : {_array = ["Motorcycle","ReammoBox","ReammoBox_F","Quadbike_01_base_F","Strategic"];};
		//PO-30
		case "O_Heli_Light_02_F"     : {_array = ["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car"];};

		case "RHS_UH1Y_d" : {_array = (["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car","Truck","Wheeled_APC_F","Air","Ship"]) + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);};

		//UH80
		case "B_Heli_Transport_01_F" : {_array = (["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car","Truck","Wheeled_APC_F","Air","Ship"]) + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);};
		//UH80 - CAMO
		case "B_Heli_Transport_01_camo_F" : {_array = (["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car","Truck","Wheeled_APC_F","Air","Ship"]) + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);};
		//CH49
		case "I_Heli_Transport_02_F" : {_array = (["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car","Truck","Wheeled_APC_F","Tracked_APC","APC_Tracked_01_base_F","APC_Tracked_02_base_F","Air","Ship","Tank"]) + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);};

		case "RHS_CH_47F_10" : {_array = (["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car","Truck","Wheeled_APC_F","Tracked_APC","APC_Tracked_01_base_F","APC_Tracked_02_base_F","Air","Ship","Tank"]) + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);};

		case "B_SDV_01_F" : {_array = (["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car","Truck","Wheeled_APC_F","Tracked_APC","APC_Tracked_01_base_F","APC_Tracked_02_base_F","Air","Ship","Tank"]) + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);};

		default {
			private ["_MaxCargoMass"];
			_MaxCargoMass = getNumber (configFile >> "CfgVehicles" >> typeOf _chopper >> "slingLoadMaxCargoMass");
			switch (true) do {
				case (_MaxCargoMass  <= 500) : {_array = ["Motorcycle","ReammoBox","ReammoBox_F","Quadbike_01_base_F","Strategic"];};
				case (_MaxCargoMass  <= 4100) : {_array = (["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car","Truck_F","Truck","Wheeled_APC_F","Air","Ship"]) + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);};
				case (_MaxCargoMass  <= 14000) : {_array = (["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car","Truck_F","Truck","Wheeled_APC_F","Tracked_APC","APC_Tracked_01_base_F","APC_Tracked_02_base_F","Air","Ship","Tank"]) + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);};
				default {_array = (["Motorcycle","ReammoBox","ReammoBox_F","StaticWeapon","Car","Truck","Truck_F","Wheeled_APC","Tracked_APC","APC_Tracked_01_base_F","APC_Tracked_02_base_F","Air","Ship","Tank"]) + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);};
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
btc_player_side		= west;
btc_respawn_marker	= "respawn_west";
btc_hq = objNull;
// Get all faction from mod there are currently running
//copyToClipboard str (["EN"] call btc_fnc_get_class);
private _allfaction = ["BLU_F","BLU_G_F","IND_F","IND_G_F","OPF_F","OPF_G_F","TBAN","UNSUNG","BTC_AM","CAF_AG_AFR_P","CAF_AG_EEUR_R","CAF_AG_ME_T","CUP_B_CZ","CUP_B_GER","CUP_B_US_ARMY","CUP_I_NAPA","CUP_I_PMC_ION","CUP_I_RACS","CUP_O_SLA","CUP_O_TK","CUP_B_GB","CUP_I_TK_GUE","CUP_I_UN","CUP_O_CHDKZ","CUP_O_TK_MILITIA","CUP_B_CDF","CUP_B_RNZN","CUP_B_USMC","CUP_O_RU","BLU_CTRG_F","BLU_GEN_F","BLU_T_F","IND_C_F","OPF_T_F","FOW_IJA","FOW_UK","FOW_USA","FOW_USMC","FOW_WEHRMACHT","LIB_ACI","LIB_ARR","LIB_DAK","LIB_FFI","LIB_GUER","LIB_LUFTWAFFE","LIB_LUFTWAFFE_W","LIB_MKHL","LIB_NAC","LIB_NKVD","LIB_PANZERWAFFE","LIB_PANZERWAFFE_W","LIB_RAAF","LIB_RAF","LIB_RBAF","LIB_RKKA","LIB_RKKA_W","LIB_US_AIRFORCE","LIB_US_AIRFORCE_W","LIB_US_ARMY","LIB_US_ARMY_W","LIB_US_RANGERS","LIB_US_TANK_TROOPS","LIB_US_TANK_TROOPS_W","LIB_USSR_AIRFORCE","LIB_USSR_AIRFORCE_W","LIB_USSR_TANK_TROOPS","LIB_USSR_TANK_TROOPS_W","LIB_WEHRMACHT","LIB_WEHRMACHT_W","LOP_BH","LOP_IRA","LOP_UVF","LOP_AA","LOP_AFR","LOP_AFR_OPF","LOP_AM","LOP_AM_OPF","LOP_CDF","LOP_CHDKZ","LOP_IA","LOP_IRAN","LOP_ISTS","LOP_ISTS_OPF","LOP_NAPA","LOP_PESH","LOP_PESH_IND","LOP_PMC","LOP_RACS","LOP_SLA","LOP_TKA","LOP_UA","LOP_UKR","LOP_UN","LOP_US","OPTRE_INS","OPTRE_PD","OPTRE_UNSC","RHS_FACTION_INSURGENTS","RHS_FACTION_MSV","RHS_FACTION_RVA","RHS_FACTION_TV","RHS_FACTION_VDV","RHS_FACTION_VMF","RHS_FACTION_VPVO","RHS_FACTION_VV","RHS_FACTION_VVS","RHS_FACTION_VVS_C","RHSGREF_FACTION_CDF_AIR","RHSGREF_FACTION_CDF_AIR_B","RHSGREF_FACTION_CDF_GROUND","RHSGREF_FACTION_CDF_GROUND_B","RHSGREF_FACTION_CDF_NG","RHSGREF_FACTION_CDF_NG_B","RHSGREF_FACTION_CHDKZ","RHSGREF_FACTION_CHDKZ_G","RHSGREF_FACTION_UN","RHSSAF_FACTION_AIRFORCE","RHSSAF_FACTION_ARMY","RHSSAF_FACTION_UN","RHS_FACTION_SOCOM","RHS_FACTION_USAF","RHS_FACTION_USARMY_D","RHS_FACTION_USARMY_WD","RHS_FACTION_USMC_D","RHS_FACTION_USMC_WD","RHS_FACTION_USN","RHSGREF_FACTION_NATIONALIST","SG_STURM","SG_STURM_W","SG_STURMPANZER","UNSUNG_AUS","UNSUNG_E","UNSUNG_EV","UNSUNG_G","UNSUNG_NZ","UNSUNG_W","USML_AIF"]; //All factions
_p_en = _allfaction select _p_en;	//Select faction selected from mission parameter
_allclasse = [[_p_en /*, "IND_F"*/], _p_en_AA, _p_en_tank] call btc_fnc_mil_class;	//Create classes from the corresponding factions [_p_en , "IND_F"], you can combine factions from the SAME side.

//Save class name to global variable
btc_enemy_side = _allclasse select 0;
btc_type_units = _allclasse select 1;
btc_type_divers = _allclasse select 2;
btc_type_crewmen = _allclasse select 3;
btc_type_boats = _allclasse select 4;
btc_type_motorized = _allclasse select 5;
btc_type_mg = _allclasse select 6;
btc_type_gl = _allclasse select 7;

//Sometimes you need to remove units: - ["Blabla","moreBlabla"];
//Sometimes you need to add units: + ["Blabla","moreBlabla"];
switch (_p_en) do {
	/*case "Myfactionexmple" : {
		btc_type_units = btc_type_units - ["Blabla","moreBlabla"];
		btc_type_divers = btc_type_divers + ["Blabla","moreBlabla"];
		btc_type_crewmen = btc_type_crewmen + ["Blabla","moreBlabla"] - ["Blabla","moreBlabla"];
		btc_type_boats = btc_type_boats;
		btc_type_motorized = btc_type_motorized;
		btc_type_mg = btc_type_mg;
		btc_type_g = btc_type_g;
	};*/
	case "IND_G_F" : {
		btc_type_motorized		= btc_type_motorized + ["I_Truck_02_transport_F","I_Truck_02_covered_F"];
		btc_type_units			= btc_type_units - ["I_G_Survivor_F"];
	};
	case "FOW_USMC" : {
		btc_type_units		= btc_type_units - ["fow_s_usmc_01_private"];
	};
	case "FOW_USA" : {
		btc_type_units		= btc_type_units - ["fow_s_usa_01_private"];
	};
	case "FOW_UK" : {
		btc_type_units		= btc_type_units - ["fow_s_uk_01_private"];
	};
};

//Rep
btc_rep_bonus_cache = 100;
btc_rep_bonus_civ_hh = 3;
btc_rep_bonus_disarm = 25;
btc_rep_bonus_hideout = 200;
btc_rep_bonus_mil_killed = 0.25;

btc_rep_malus_civ_hd = - 10;
btc_rep_malus_civ_killed = - 10;
btc_rep_malus_civ_firenear = - 5;
btc_rep_malus_player_respawn = - 10;
btc_rep_malus_veh_killed = - 25;

//Side
if (isNil "btc_side_assigned") then {btc_side_assigned = false;};

//Skill
btc_AI_skill = _p_skill;

//Headless
btc_units_owners = [];