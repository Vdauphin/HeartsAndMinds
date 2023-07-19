
/* ----------------------------------------------------------------------------
Function: btc_eh_fnc_headless

Description:
    Add local events handler to headless client.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_eh_fnc_headless;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

["Animal", "InitPost", {
    [_this select 0, "HandleDamage", btc_rep_fnc_hd] call CBA_fnc_addBISEventHandler;
}, true, [], true] call CBA_fnc_addClassEventHandler;
{
    [_x, "InitPost", {
        [_this select 0, "Suppressed", btc_rep_fnc_suppressed] call CBA_fnc_addBISEventHandler;
        [_this select 0, "HandleDamage", btc_rep_fnc_hd] call CBA_fnc_addBISEventHandler;
    }, false, [], true] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_units;
{
    [_x, "InitPost", {
        [_this select 0, "HandleDamage", btc_rep_fnc_hd] call CBA_fnc_addBISEventHandler;
    }, false, [], true] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_veh;
["ace_disarming_dropItems", btc_rep_fnc_foodRemoved] call CBA_fnc_addEventHandler;
["ace_repair_setWheelHitPointDamage", {
    _this remoteExecCall ["btc_rep_fnc_wheelChange", 2];
}] call CBA_fnc_addEventHandler;

{
    [_x, "InitPost", {
        [_this select 0, "HandleDamage", btc_patrol_fnc_disabled] call CBA_fnc_addBISEventHandler;
    }, false, [], true] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_veh;
