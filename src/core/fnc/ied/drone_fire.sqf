
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_drone_fire

Description:
    Fire bomb of the drone.

Parameters:
    _trigger - Trigger. [Object]

Returns:

Examples:
    (begin example)
        [_trigger] call btc_ied_fnc_drone_fire;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_trigger", objNull, [objNull]]
];
private _driver_drone = _trigger getVariable "btc_ied_drone";

if (alive _driver_drone) then {
    _driver_drone forceWeaponFire ["BombDemine_01_F", "BombDemine_01_F"];
};
