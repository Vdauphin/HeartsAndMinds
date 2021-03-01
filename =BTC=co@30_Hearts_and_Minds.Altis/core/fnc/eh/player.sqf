
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_player

Description:
    Add event handler to player.

Parameters:
    _player - Player to add event. [Object]

Returns:
    _eventHandleID - ID of the WeaponAssembled event handle. [Number]

Examples:
    (begin example)
        _eventHandleID = [player] call btc_fnc_eh_player;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

[_player, "Respawn", {
    if !(ace_map_mapIllumination) then {ace_map_mapIllumination = btc_map_mapIllumination;};
}] call CBA_fnc_addBISEventHandler;
["ace_killed", {
    params ["_unit"];
    if !(_unit isEqualTo player) exitWith {};
    if (ace_map_mapIllumination) then {ace_map_mapIllumination = false;};
    if (isObjectHidden player) exitWith {};
    [btc_rep_malus_player_respawn, player] remoteExecCall ["btc_fnc_rep_change", 2];
}] call CBA_fnc_addEventHandler;
_player addEventHandler ["CuratorObjectPlaced", btc_fnc_eh_CuratorObjectPlaced];
["ace_treatmentSucceded", btc_fnc_rep_treatment] call CBA_fnc_addEventHandler;
_player addEventHandler ["WeaponAssembled", btc_fnc_civ_add_leaflets];
[_player, "WeaponAssembled", {[_thisType, _this] call btc_fnc_fob_rallypointAssemble;}] call CBA_fnc_addBISEventHandler;
[_player, "WeaponDisassembled", {[_thisType, _this] call btc_fnc_fob_rallypointAssemble;}] call CBA_fnc_addBISEventHandler;
_player addEventHandler ["GetInMan", {_this call btc_fnc_ied_deleteLoop}];
_player addEventHandler ["GetOutMan", {
    if (btc_ied_deleteOn > -1) then {
        [btc_ied_deleteOn] call CBA_fnc_removePerFrameHandler;
        btc_ied_deleteOn = -1;
    };
}];
_player addEventHandler ["WeaponAssembled", {
    params ["_player", "_static"];

    if !(_static isKindOf "StaticWeapon") exitWith {_this};
    [_static] remoteExecCall ["btc_fnc_log_init", 2];
}];
["ace_csw_deployWeaponSucceeded", {
    _this remoteExecCall ["btc_fnc_log_init", 2];
}] call CBA_fnc_addEventHandler;
["btc_tow_unwindDone", {(localize "STR_BTC_HAM_TOW_DONE") call CBA_fnc_notify}] call CBA_fnc_addEventHandler;

if (btc_p_chem) then {
     // Add biopsy
    [missionNamespace, "probingEnded", btc_fnc_chem_biopsy] call BIS_fnc_addScriptedEventHandler;

    // Disable BI shower
    ["DeconShower_01_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction', true];}] call CBA_fnc_addClassEventHandler;
    ["DeconShower_02_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction', true];}] call CBA_fnc_addClassEventHandler;

    [] call btc_fnc_chem_ehDetector;
};

if (btc_p_spect) then {
    ["weapon", {_this call btc_fnc_spect_updateDevice}] call CBA_fnc_addPlayerEventHandler;
    ["vehicle", {
        params ["_unit", "_newVehicle"];
        [] call btc_fnc_spect_disableDevice;
        [_unit, currentWeapon _unit] call btc_fnc_spect_updateDevice;
    }] call CBA_fnc_addPlayerEventHandler;
};

if (btc_p_respawn_arsenal) then {
    [_player, "Respawn", {
        params ["_unit", "_corpse"];
        if (isObjectHidden _corpse) exitWith {};
        [btc_gear_object, _unit] call ace_arsenal_fnc_openBox;
    }] call CBA_fnc_addBISEventHandler;
};

if (btc_p_respawn_location >= 4) then {
    ["ace_killed", {
        params ["_unit"];
        if !(_unit isEqualTo player) exitWith {};
        private _group  = group player;
        [_group, leader _group] call BIS_fnc_addRespawnPosition;
    }] call CBA_fnc_addEventHandler;
};
