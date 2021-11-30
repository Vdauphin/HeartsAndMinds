
/* ----------------------------------------------------------------------------
Function: btc_veh_fnc_addRespawnableFromSQM

Description:
    Add a vehicle to the respawn array system. Only usefull in mission.sqm.

Parameters:
    _vehicle - Vehicle to add in respawn system. [Object]

Returns:

Examples:
    (begin example)
        this call btc_veh_fnc_addRespawnableFromSQM;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]]
];

if (isNil "btc_veh_respawnable") then {
    btc_veh_respawnable = [];
};
btc_veh_respawnable pushBackUnique _vehicle
