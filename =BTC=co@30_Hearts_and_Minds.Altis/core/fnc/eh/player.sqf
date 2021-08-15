
/* ----------------------------------------------------------------------------
Function: btc_eh_fnc_player

Description:
    Add event handler to player.

Parameters:
    _player - Player to add event. [Object]

Returns:
    _eventHandleID - ID of the WeaponAssembled event handle. [Number]

Examples:
    (begin example)
        _eventHandleID = [player] call btc_eh_fnc_player;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

[_player, "Respawn", {
    params ["_unit", "_corpse"];
    _corpse connectTerminalToUAV objNull;
    if !(ace_map_mapIllumination) then {ace_map_mapIllumination = btc_map_mapIllumination;};
}] call CBA_fnc_addBISEventHandler;
["ace_killed", {
    params ["_unit"];
    if (_unit isNotEqualTo player) exitWith {};
    if (ace_map_mapIllumination) then {ace_map_mapIllumination = false;};
    if (isObjectHidden player) exitWith {};
    [btc_rep_malus_player_respawn, player] remoteExecCall ["btc_rep_fnc_change", 2];
}] call CBA_fnc_addEventHandler;
_player addEventHandler ["CuratorObjectPlaced", btc_eh_fnc_CuratorObjectPlaced];
["ace_treatmentSucceded", btc_rep_fnc_treatment] call CBA_fnc_addEventHandler;
_player addEventHandler ["WeaponAssembled", btc_civ_fnc_add_leaflets];
[_player, "WeaponAssembled", {[_thisType, _this] call btc_fob_fnc_rallypointAssemble;}] call CBA_fnc_addBISEventHandler;
[_player, "WeaponDisassembled", {[_thisType, _this] call btc_fob_fnc_rallypointAssemble;}] call CBA_fnc_addBISEventHandler;
_player addEventHandler ["GetInMan", {_this call btc_ied_fnc_deleteLoop}];
_player addEventHandler ["GetOutMan", {
    if (btc_ied_deleteOn > -1) then {
        [btc_ied_deleteOn] call CBA_fnc_removePerFrameHandler;
        btc_ied_deleteOn = -1;
    };
}];
_player addEventHandler ["WeaponAssembled", {
    params ["_player", "_static"];

    if !(_static isKindOf "StaticWeapon") exitWith {_this};
    [_static] remoteExecCall ["btc_log_fnc_init", 2];
}];
["ace_csw_deployWeaponSucceeded", {
    _this remoteExecCall ["btc_log_fnc_init", 2];
}] call CBA_fnc_addEventHandler;

if (btc_p_chem) then {
     // Add biopsy
    [missionNamespace, "probingEnded", btc_chem_fnc_biopsy] call BIS_fnc_addScriptedEventHandler;

    // Disable BI shower
    ["DeconShower_01_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction', true];}] call CBA_fnc_addClassEventHandler;
    ["DeconShower_02_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction', true];}] call CBA_fnc_addClassEventHandler;

    [] call btc_chem_fnc_ehDetector;
};

if (btc_p_spect) then {
    ["weapon", {_this call btc_spect_fnc_updateDevice}] call CBA_fnc_addPlayerEventHandler;
    ["vehicle", {
        params ["_unit", "_newVehicle"];
        [] call btc_spect_fnc_disableDevice;
        [_unit, currentWeapon _unit] call btc_spect_fnc_updateDevice;
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
        if (_unit isNotEqualTo player) exitWith {};
        private _group  = group player;
        [_group, leader _group] call BIS_fnc_addRespawnPosition;
    }] call CBA_fnc_addEventHandler;
};
