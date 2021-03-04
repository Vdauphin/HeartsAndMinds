[] call compile preprocessFileLineNumbers "core\fnc\city\init.sqf";

["Initialize"] call BIS_fnc_dynamicGroups;
setTimeMultiplier btc_p_acctime;

["btc_m", -1, objNull, "", false, false] call btc_fnc_task_create;
[["btc_dft", "btc_m"], 0] call btc_fnc_task_create;
[["btc_dty", "btc_m"], 1] call btc_fnc_task_create;

if (btc_db_load && {profileNamespace getVariable [format ["btc_hm_%1_db", worldName], false]}) then {
    if ((profileNamespace getVariable [format ["btc_hm_%1_version", worldName], 1.13]) in [btc_version select 1, 20.1]) then {
        [] call compile preprocessFileLineNumbers "core\fnc\db\load.sqf";
    } else {
        [] call compile preprocessFileLineNumbers "core\fnc\db\load_old.sqf";
    };
} else {
    for "_i" from 1 to btc_hideout_n do {[] call btc_fnc_mil_create_hideout;};
    [] call btc_fnc_cache_init;

    private _date = date;
    _date set [3, btc_p_time];
    setDate _date;

    {
        _x setVariable ["btc_EDENinventory", [getWeaponCargo _x, getMagazineCargo _x, getItemCargo _x, getBackpackCargo _x]];
        _x call btc_fnc_db_add_veh;
    } forEach btc_vehicles;
};

[] call btc_fnc_eh_server;
[btc_ied_list] call btc_fnc_ied_fired_near;
[] call btc_fnc_chem_checkLoop;
[] call btc_fnc_chem_handleShower;
[] call btc_fnc_spect_checkLoop;
if (btc_p_db_autoRestart > 0) then {
    [{
        [19] remoteExecCall ["btc_fnc_show_hint", [0, -2] select isDedicated];
        [{
            [] call btc_fnc_db_autoRestart;
        }, [], 5 * 60] call CBA_fnc_waitAndExecute;
    }, [], btc_p_db_autoRestartTime * 60 * 60 - 5 * 60] call CBA_fnc_waitAndExecute;
};

{
    _x setVariable ["btc_EDENinventory", [getWeaponCargo _x, getMagazineCargo _x, getItemCargo _x, getBackpackCargo _x]];
    [_x, 30] call btc_fnc_veh_addRespawn;
} forEach btc_helo;

if (btc_p_side_mission_cycle > 0) then {
    for "_i" from 1 to btc_p_side_mission_cycle do {
        [true] spawn btc_fnc_side_create;
    };
};

{
    ["btc_tag_remover" + _x, "STR_BTC_HAM_ACTION_REMOVETAG", _x, ["#(rgb,8,8,3)color(0,0,0,0)"], "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"] call ace_tagging_fnc_addCustomTag;
} forEach ["ACE_SpraypaintRed"];
