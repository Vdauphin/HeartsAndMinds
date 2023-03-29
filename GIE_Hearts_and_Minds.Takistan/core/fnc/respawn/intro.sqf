
/* ----------------------------------------------------------------------------
Function: btc_respawn_fnc_intro

Description:
    Introduction camera.

Parameters:
    _gear_object - Arsenal position. [String]
    _create_object - Repair/Logistic position. [Object]

Returns:

Examples:
    (begin example)
        [] call btc_respawn_fnc_intro;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_gear_object", btc_gear_object, [""]],
    ["_create_object", btc_create_object, [objNull]]
];

private _color = [1, 0.5, 0,1];

private _gear_object_pos = getPos _gear_object;
_gear_object_pos params ["_gear_object_pos_x", "_gear_object_pos_y", "_gear_object_pos_z"];
private _create_object_pos = getPos _create_object;
_create_object_pos params ["_create_object_pos_x", "_create_object_pos_y", "_create_object_pos_z"];

private _array = [
    ['\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa', _color, _gear_object_pos, 1.1, 1.1, 0, localize "STR_BTC_HAM_INTRO_ARSENAL_REDEPLOY", 1], //Arsenal/Re-deploy
    ['\A3\Ui_f\data\Logos\a_64_ca.paa', _color, [_gear_object_pos_x, _gear_object_pos_y, _gear_object_pos_z + 2], 1.1, 1.1, 0, "", 1],
    //['\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa', _color, [_create_object_pos_x, _create_object_pos_y, _create_object_pos_z + 5], 0.9, 0.9, 90, "", 1],
    ['\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa', _color, [_create_object_pos_x, _create_object_pos_y, _create_object_pos_z + 2.5], 0.9, 0.9, 0, "", 1],
    ['\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa', _color, _create_object_pos, 0.9, 0.9, 0, localize "STR_BTC_HAM_INTRO_LOGPOINT", 1] //Rearm/Repair and Objects
];
if !(isNil "btc_veh_respawnable_1") then {
    _array pushBack ['\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca.paa', [0.7, 0, 0,1], getPos btc_veh_respawnable_1, 1.1, 1.1, 0, localize "STR_BTC_HAM_INTRO_ONLYRESPAWN", 1]; //Only Respawnable
};

waitUntil {time > 0}; //Wait for date synchronisation

private _startingDate = btc_startDate select [0, 3];
private _date = date select [0, 3];
private _days = (_date vectorDiff _startingDate) vectorDotProduct [365, 30.5, 1];
[
    getMarkerPos "btc_base",
    format [localize "STR_BTC_HAM_INTRO_LOADINGTXT", round _days],
    20, 30, 240, 0, _array, 0
] call BIS_fnc_establishingShot;

enableSaving [false, false];
