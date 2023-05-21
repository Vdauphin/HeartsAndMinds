
/* ----------------------------------------------------------------------------
Function: btc_civ_fnc_class

Description:
    Return civilian classe names sorted by units, boats and vehicules based on faction name.

Parameters:
    _factions - Faction name used to get civilian classe name sorted. [Array]

Returns:
    _civilian_classe_names - Array of units, boats and vehicules classe names. [Array]

Examples:
    (begin example)
        _civilian_classe_names = ["CIV_F"] call btc_civ_fnc_class;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_factions", [], [[]]]
];

private _type_units = [];
private _type_boats = [];
private _type_veh = [];

//Get all vehicles
private _cfgVehicles = configFile >> "CfgVehicles";
private _allClass = ("(configName _x) isKindOf 'AllVehicles'" configClasses _cfgVehicles) apply {configName _x};
_allClass = _allClass select {getNumber(_cfgVehicles >> _x >> "scope") isEqualTo 2};

//Check if faction existe
private _cfgFactionClasses = configFile >> "CfgFactionClasses";
_factions = _factions apply {
    if !(isClass(_cfgFactionClasses >> _x)) then {
        "CIV_F"
    } else {
        _x
    };
};

{
    private _faction = _x;

    //Get all vehicles of the _faction selected
    private _allClass_f = _allClass select {(toUpper getText(_cfgVehicles >> _x >> "faction")) isEqualTo _faction};

    //Units
    _type_units append (_allClass_f select {_x isKindOf "Man"});

    //Vehicles
    _type_boats append (_allClass_f select {_x isKindOf "Ship"});

    _type_veh append (_allClass_f select {(_x isKindOf "Car") || (_x isKindOf "Truck") || (_x isKindOf "Truck_F")});

} forEach _factions;

//Handle if no class name is found
if (_type_units isEqualTo []) then {
    _type_units = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_euro","C_man_polo_1_F_asia","C_man_polo_2_F","C_man_polo_2_F_afro","C_man_polo_2_F_euro","C_man_polo_2_F_asia","C_man_polo_3_F","C_man_polo_3_F_afro","C_man_polo_3_F_euro","C_man_polo_3_F_asia","C_man_polo_4_F","C_man_polo_4_F_afro","C_man_polo_4_F_euro","C_man_polo_4_F_asia","C_man_polo_5_F","C_man_polo_5_F_afro","C_man_polo_5_F_euro","C_man_polo_5_F_asia","C_man_polo_6_F","C_man_polo_6_F_afro","C_man_polo_6_F_euro","C_man_polo_6_F_asia","C_man_p_fugitive_F","C_man_p_fugitive_F_afro","C_man_p_fugitive_F_euro","C_man_p_fugitive_F_asia","C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_beggar_F_euro","C_man_p_beggar_F_asia","C_man_w_worker_F","C_man_hunter_1_F","C_Orestes","C_Nikos","C_Man_casual_4_F","C_Man_casual_5_F","C_Man_casual_6_F","C_Man_sport_1_F","C_Man_sport_2_F","C_Man_sport_3_F","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F"]
};
if (_type_boats isEqualTo []) then {
    _type_boats = ["C_Rubberboat","C_Boat_Civil_01_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_police_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F"];
};
if (_type_veh isEqualTo []) then {
    _type_veh = ["C_Hatchback_01_F","C_SUV_01_F","C_Offroad_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Truck_02_transport_F","C_Truck_02_covered_F","C_Offroad_02_unarmed_F"]
};

//Final filter unwanted units type
_type_units = _type_units select {
    getText (_cfgVehicles >> _x >> "role") isNotEqualTo "Crewman" &&
    (_x find "_unarmed_") isEqualTo -1 &&
    getText (_cfgVehicles >> _x >> "vehicleClass") isNotEqualTo "MenVR"
};
_type_veh = _type_veh select {(getNumber (_cfgVehicles >> _x >> "isUav") isNotEqualTo 1) && !(_x isKindOf "Kart_01_Base_F")};

[_type_units, _type_boats, _type_veh]
