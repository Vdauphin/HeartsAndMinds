[] call compileScript ["core\fnc\city\init.sqf"];

["Initialize"] call BIS_fnc_dynamicGroups;
setTimeMultiplier btc_p_acctime;

["btc_m", -1, objNull, "", false, false] call btc_task_fnc_create;
[["btc_dft", "btc_m"], 0] call btc_task_fnc_create;
[["btc_dty", "btc_m"], 1] call btc_task_fnc_create;

[format ["[%1, %2]", btc_db_load, profileNamespace getVariable [format ["btc_hm_%1_db", worldName], false]], __FILE__, [false, true]] call btc_debug_fnc_message;

if (btc_db_load && {profileNamespace getVariable [format ["btc_hm_%1_db", worldName], false]}) then {
    ["Loading save", __FILE__, [false, true]] call btc_debug_fnc_message;
    if ((profileNamespace getVariable [format ["btc_hm_%1_version", worldName], 1.13]) in [btc_version select 1, 22.1]) then {
        [] call compileScript ["core\fnc\db\load.sqf"];
    } else {
        [] call compileScript ["core\fnc\db\load_old.sqf"];
    };
} else {
    ["Generating new game", __FILE__, [false, true]] call btc_debug_fnc_message;
    if (btc_hideout_n > 0) then {
        ["Generating hideout", __FILE__, [false, true]] call btc_debug_fnc_message;
        for "_i" from 1 to btc_hideout_n do {[] call btc_hideout_fnc_create;};
    } else {
        ["Generating final phase", __FILE__, [false, true]] call btc_debug_fnc_message;
        [] spawn btc_fnc_final_phase;
    };

    ["Generating cache", __FILE__, [false, true]] call btc_debug_fnc_message;
    [] call btc_cache_fnc_init;

    ["Setting start date", __FILE__, [false, true]] call btc_debug_fnc_message;
    btc_startDate set [3, btc_p_time];
    setDate btc_startDate;

    ["Initializing vehicles", __FILE__, [false, true]] call btc_debug_fnc_message;
    {
        _x call btc_veh_fnc_add;
    } forEach (getMissionLayerEntities "btc_vehicles" select 0);
    if (isNil "btc_vehicles") then {btc_vehicles = [];};
    ["New game setup completed", __FILE__, [false, true]] call btc_debug_fnc_message;
};

[] call btc_eh_fnc_server;
[btc_ied_list] call btc_ied_fnc_fired_near;
[] call btc_chem_fnc_checkLoop;
[] call btc_chem_fnc_handleShower;
[] call btc_spect_fnc_checkLoop;
[] call btc_db_fnc_autoRestartLoop;

{
    [_x, 30] call btc_veh_fnc_addRespawn;
    if (_forEachIndex isEqualTo 0) then {
        missionNamespace setVariable ["btc_veh_respawnable_1", _x, true];
    };
} forEach (getMissionLayerEntities "btc_veh_respawnable" select 0);
if (isNil "btc_veh_respawnable") then {btc_veh_respawnable = [];};

if (btc_p_side_mission_cycle > 0) then {
    for "_i" from 1 to btc_p_side_mission_cycle do {
        [true] spawn btc_side_fnc_create;
    };
};

{
    ["btc_tag_remover" + _x, "STR_BTC_HAM_ACTION_REMOVETAG", _x, ["#(rgb,8,8,3)color(0,0,0,0)"], "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"] call ace_tagging_fnc_addCustomTag;
} forEach ["ACE_SpraypaintRed"];

if (
    btc_p_respawn_ticketsShare &&
    {btc_p_respawn_ticketsAtStart >= 0}
) then {
    private _tickets = btc_respawn_tickets getOrDefault [btc_player_side, btc_p_respawn_ticketsAtStart];;
    if (_tickets isEqualTo 0) then {
        _tickets = -1;
    };
    [btc_player_side, _tickets] call BIS_fnc_respawnTickets;
};

[] call gie_db_fnc_autoSave;