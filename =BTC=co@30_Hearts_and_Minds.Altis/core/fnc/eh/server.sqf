
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

addMissionEventHandler ["BuildingChanged", btc_fnc_rep_buildingchanged];
["ace_explosives_defuse", btc_fnc_rep_explosives_defuse] call CBA_fnc_addEventHandler;
["ace_killed", btc_fnc_rep_killed] call CBA_fnc_addEventHandler;
["Animal", "InitPost", {
    [(_this select 0), "HandleDamage", btc_fnc_rep_hd] call CBA_fnc_addBISEventHandler;
}] call CBA_fnc_addClassEventHandler;
["Animal", "killed", {
    params ["_unit", "_killer", "_instigator"];
    [_unit, "", _killer, _instigator] call btc_fnc_rep_killed;
}] call CBA_fnc_addClassEventHandler;
{
    [_x, "InitPost", {
        [(_this select 0), "Suppressed", btc_fnc_rep_suppressed] call CBA_fnc_addBISEventHandler;
        [(_this select 0), "HandleDamage", btc_fnc_rep_hd] call CBA_fnc_addBISEventHandler;
    }, false] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_units;
{
    [_x, "InitPost", {
        [(_this select 0), "HandleDamage", btc_fnc_rep_hd] call CBA_fnc_addBISEventHandler;
    }, false] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_veh;
["ace_killed", btc_fnc_mil_unit_killed] call CBA_fnc_addEventHandler;

addMissionEventHandler ["HandleDisconnect", {
    params ["_headless"];
    if (_headless in (entities "HeadlessClient_F")) then {
        deleteVehicle _headless;
    };
}];
if (btc_p_auto_db) then {
    addMissionEventHandler ["HandleDisconnect", {
        if ((allPlayers - entities "HeadlessClient_F") isEqualTo []) then {
            [] call btc_fnc_db_save;
        };
    }];
};
if (btc_p_chem) then {
    ["ace_cargoLoaded", btc_fnc_chem_propagate] call CBA_fnc_addEventHandler;
    ["AllVehicles", "GetIn", {[_this select 0, _this select 2] call btc_fnc_chem_propagate}] call CBA_fnc_addClassEventHandler;
    ["DeconShower_01_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction',true]}] call CBA_fnc_addClassEventHandler;
    ["DeconShower_02_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction',true]}] call CBA_fnc_addClassEventHandler;
};

["GroundWeaponHolder", "InitPost", {btc_groundWeaponHolder append _this}] call CBA_fnc_addClassEventHandler;
["acex_fortify_objectPlaced", {[_this select 2] call btc_fnc_log_init}] call CBA_fnc_addEventHandler;
if (btc_p_set_skill) then {
    ["CAManBase", "InitPost", btc_fnc_mil_set_skill] call CBA_fnc_addClassEventHandler;
};
["btc_delay_vehicleInit", btc_fnc_patrol_addEH] call CBA_fnc_addEventHandler;
["ace_killed", {
    params ["_unit"];
    if (!(side group _unit isEqualTo civilian)) exitWith {};
    private _vehicle = assignedVehicle _unit;
    if !(_vehicle isEqualTo objNull) then {
        [[], [_vehicle]] call btc_fnc_delete;
    };
}] call CBA_fnc_addEventHandler;
{
    [_x, "InitPost", {
        [(_this select 0), "HandleDamage", btc_fnc_patrol_disabled] call CBA_fnc_addBISEventHandler;
    }, false] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_veh;
["ace_tagCreated", btc_fnc_tag_eh] call CBA_fnc_addEventHandler;
