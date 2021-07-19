[] call compileScript ["core\fnc\city\init.sqf"];

["Initialize"] call BIS_fnc_dynamicGroups;
setTimeMultiplier btc_p_acctime;

["btc_m", -1, objNull, "", false, false] call btc_task_fnc_create;
[["btc_dft", "btc_m"], 0] call btc_task_fnc_create;
[["btc_dty", "btc_m"], 1] call btc_task_fnc_create;

if (btc_db_load && {profileNamespace getVariable [format ["btc_hm_%1_db", worldName], false]}) then {
    if ((profileNamespace getVariable [format ["btc_hm_%1_version", worldName], 1.13]) in [btc_version select 1, 20.1]) then {
        [] call compileScript ["core\fnc\db\load.sqf"];
    } else {
        [] call compileScript ["core\fnc\db\load_old.sqf"];
    };
} else {
    for "_i" from 1 to btc_hideout_n do {[] call btc_hideout_fnc_create;};
    [] call btc_cache_fnc_init;

    private _date = date;
    _date set [3, btc_p_time];
    setDate _date;

    {
        _x setVariable ["btc_EDENinventory", _x call btc_log_fnc_inventoryGet];
        _x call btc_db_fnc_add_veh;
    } forEach btc_vehicles;
};

[] call btc_eh_fnc_server;
[btc_ied_list] call btc_ied_fnc_fired_near;
[] call btc_chem_fnc_checkLoop;
[] call btc_chem_fnc_handleShower;
[] call btc_spect_fnc_checkLoop;
if (btc_p_db_autoRestart > 0) then {
    [{
        [19] remoteExecCall ["btc_fnc_show_hint", [0, -2] select isDedicated];
        [{
            [] call btc_db_fnc_autoRestart;
        }, [], 5 * 60] call CBA_fnc_waitAndExecute;
    }, [], btc_p_db_autoRestartTime * 60 * 60 - 5 * 60] call CBA_fnc_waitAndExecute;
};

{
    _x setVariable ["btc_EDENinventory", _x call btc_log_fnc_inventoryGet];
    [_x, 30] call btc_veh_fnc_addRespawn;
} forEach btc_helo;

if (btc_p_side_mission_cycle > 0) then {
    for "_i" from 1 to btc_p_side_mission_cycle do {
        [true] spawn btc_side_fnc_create;
    };
};

{
    ["btc_tag_remover" + _x, "STR_BTC_HAM_ACTION_REMOVETAG", _x, ["#(rgb,8,8,3)color(0,0,0,0)"], "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"] call ace_tagging_fnc_addCustomTag;
} forEach ["ACE_SpraypaintRed"];

if (btc_p_respawn_ticketsAtStart >= 0) then {
    [btc_player_side, btc_p_respawn_ticketsAtStart] call BIS_fnc_respawnTickets;
};
