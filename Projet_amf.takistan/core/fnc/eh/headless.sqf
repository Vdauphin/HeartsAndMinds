
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_headless

Description:
    Add local events handler to headless client.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_fnc_eh_headless;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

["Animal", "InitPost", {
    [(_this select 0), "HandleDamage", btc_fnc_rep_hd] call CBA_fnc_addBISEventHandler;
}, true, [], true] call CBA_fnc_addClassEventHandler;

{
    [_x, "InitPost", {
        [(_this select 0), "Suppressed", btc_fnc_rep_suppressed] call CBA_fnc_addBISEventHandler;
        [(_this select 0), "HandleDamage", btc_fnc_rep_hd] call CBA_fnc_addBISEventHandler;
    }, false, [], true] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_units;
{
    [_x, "InitPost", {
        [(_this select 0), "HandleDamage", btc_fnc_rep_hd] call CBA_fnc_addBISEventHandler;
    }, false, [], true] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_veh;

{
    [_x, "InitPost", {
        [(_this select 0), "HandleDamage", btc_fnc_patrol_disabled] call CBA_fnc_addBISEventHandler;
    }, false, [], true] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_veh;

