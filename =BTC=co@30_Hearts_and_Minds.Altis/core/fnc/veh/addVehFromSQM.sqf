
/* ----------------------------------------------------------------------------
Function: btc_veh_fnc_addVehFromSQM

Description:
    Add vehicle to the wreck array system. Only usefull in mission.sqm.

Parameters:
    _vehicle - Vehicle to add in wreck system. [Object]

Returns:

Examples:
    (begin example)
        this call btc_veh_fnc_addVehFromSQM;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]]
];

if (isNil "btc_vehicles") then {
    btc_vehicles = [];
};
btc_vehicles pushBackUnique _vehicle
