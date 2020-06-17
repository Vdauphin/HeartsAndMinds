
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_server

Description:
    Add event handler to server.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_fnc_eh_server;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

addMissionEventHandler ["HandleDisconnect", btc_fnc_eh_handledisconnect];
addMissionEventHandler ["BuildingChanged", btc_fnc_rep_buildingchanged];
["ace_explosives_defuse", btc_fnc_rep_explosives_defuse] call CBA_fnc_addEventHandler;

if (btc_p_auto_db) then {
    addMissionEventHandler ["HandleDisconnect", btc_fnc_db_autosave];
};
if (btc_p_chem) then {
    ["ace_cargoLoaded", btc_fnc_chem_propagate] call CBA_fnc_addEventHandler;
    ["DeconShower_01_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction',true];}] call CBA_fnc_addClassEventHandler;
    ["DeconShower_02_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction',true]}] call CBA_fnc_addClassEventHandler;
};

["GroundWeaponHolder", "InitPost", {btc_groundWeaponHolder append _this}] call CBA_fnc_addClassEventHandler;
["acex_fortify_objectPlaced", {[_this select 2] call btc_fnc_log_CuratorObjectPlaced_s}] call CBA_fnc_addEventHandler;
