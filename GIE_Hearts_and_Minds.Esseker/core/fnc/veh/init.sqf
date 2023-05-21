
/* ----------------------------------------------------------------------------
Function: btc_veh_fnc_init

Description:
    Add custom ACE interaction depends one vehicle type (static weapon, land vehicle, helicopter and ship).

Parameters:
    _type - Type of vehicle to add custom ACE interaction. [String]

Returns:

Examples:
    (begin example)
        ["B_Truck_01_fuel_F"] call btc_veh_fnc_init;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_type", "", [""]]
];

if (isNil "btc_actions_veh") then {btc_actions_veh = [];};
if ((btc_actions_veh pushBackUnique _type) isEqualTo -1) exitWith {};

switch true do {
    case (_type isKindOf "UGV_02_Base_F") : {};
    case (_type isKindOf "StaticWeapon") : {};
    case (_type isKindOf "LandVehicle" || {_type isKindOf "Ship"}) : {
        _type call btc_tow_fnc_int;

        _type call btc_flag_fnc_int;
    };
    case (_type isKindOf "Helicopter") : {
        _type call btc_tow_fnc_int;

        //Lift
        _action = [
            "Deploy_ropes", localize "STR_ACE_Fastroping_Interaction_deployRopes",
            "\A3\ui_f\data\igui\cfg\simpleTasks\types\container_ca.paa",
            {[] spawn btc_lift_fnc_deployRopes;},
            {!btc_ropes_deployed && {(driver vehicle player) isEqualTo player} && {(getPosATL player) select 2 > 4}}
        ] call ace_interact_menu_fnc_createAction;
        [_type, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;
        _action = [
            "Cut_ropes", localize "STR_ACE_Fastroping_Interaction_cutRopes",
            "\z\ace\addons\logistics_wirecutter\ui\wirecutter_ca.paa",
            {[] call btc_lift_fnc_destroyRopes;},
            {btc_ropes_deployed && {(driver vehicle player) isEqualTo player}}
        ] call ace_interact_menu_fnc_createAction;
        [_type, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

        _type call btc_flag_fnc_int;
    };
    case (_type isKindOf "Plane") : {
        _type call btc_tow_fnc_int;
    };
};


