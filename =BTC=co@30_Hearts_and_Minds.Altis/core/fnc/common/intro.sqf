
private ["_color_orange","_color_red","_array"];

_color_orange = [1,0.5,0,1];
_color_red = [0.7,0,0,1];

_array = [

//Arsenal
['\A3\ui_f\data\map\vehicleicons\iconCrateWpns_ca.paa',_color_orange, getPos btc_gear_object, 1.1, 1.1, 0, "Arsenal", 1],

//['\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa',_color_orange, [getPos btc_create_object select 0,getPos btc_create_object select 1,(getPos btc_create_object select 2) + 5], 0.9, 0.9, 90, "", 1],

//Rearm and Repair
['\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa',_color_orange, getPos btc_create_object, 0.9, 0.9, 0, "Repair Station", 1],
['\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa',_color_orange, getPos btc_veh_12, 0.9, 0.9, 0, "Maintenance Trucks", 1],

//Helis
['\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca',_color_red, getPos btc_veh_10, 1.1, 1.1, 0, "CAS Heli", 1],
['\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca',_color_orange, getPos btc_veh_14, 1.1, 1.1, 0, "Transport Heli", 1],

//Vics
['\A3\ui_f\data\map\vehicleicons\iconapc_ca',_color_red, getPos btc_veh_1, 1.1, 1.1, 0, "APC", 1],
['\A3\ui_f\data\map\vehicleicons\iconcar_ca',_color_red, getPos btc_veh_4, 1.1, 1.1, 0, "Humvees", 1],
['\A3\ui_f\data\map\vehicleicons\icontruck_ca',_color_red, getPos btc_veh_15, 1.1, 1.1, 0, "Trucks", 1],
['\A3\ui_f\data\map\vehicleicons\iconstaticmortar_ca.paa',_color_red, getPos mg2_mortar, 1.1, 1.1, 0, "Mortars", 1],

//Medbay
['\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa',_color_orange, getPos mg2_medbay, 0.9, 0.9, 0, "Medical Bay", 1],
['\A3\ui_f\data\map\vehicleicons\iconparachute_ca.paa',_color_orange, [(getPos mg2_HALOcrate select 0)+5, (getPos mg2_HALOcrate select 1)+5,(getPos mg2_HALOcrate select 2)], 0.9, 0.9, 0, "HALO Point", 1]
];
//if (!isNil "btc_helo_1") then {_array pushBack ['\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca.paa',[0,0.7,0,1], getPos mg2_HALOcrate, 1.1, 1.1, 0, "HALO Point", 1];};

[getMarkerPos "btc_base","Welcome to Hearts and Minds soldier ...",75,125,720,0,_array,0] call BIS_fnc_establishingShot;

enableSaving [false,false];
