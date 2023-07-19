
/* ----------------------------------------------------------------------------
Function: btc_eh_fnc_server

Description:
    Add event handler to server.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_eh_fnc_server;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

addMissionEventHandler ["BuildingChanged", btc_rep_fnc_buildingchanged];
["ace_explosives_defuse", btc_rep_fnc_explosives_defuse] call CBA_fnc_addEventHandler;
["ace_killed", btc_rep_fnc_killed] call CBA_fnc_addEventHandler;
["Animal", "InitPost", {
    [_this select 0, "HandleDamage", btc_rep_fnc_hd] call CBA_fnc_addBISEventHandler;
}] call CBA_fnc_addClassEventHandler;
["Animal", "killed", {
    params ["_unit", "_killer", "_instigator"];
    [_unit, "", _killer, _instigator] call btc_rep_fnc_killed;
}] call CBA_fnc_addClassEventHandler;
{
    [_x, "InitPost", {
        [_this select 0, "Suppressed", btc_rep_fnc_suppressed] call CBA_fnc_addBISEventHandler;
        [_this select 0, "HandleDamage", btc_rep_fnc_hd] call CBA_fnc_addBISEventHandler;
    }, false] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_units;
{
    [_x, "InitPost", {
        [_this select 0, "HandleDamage", btc_rep_fnc_hd] call CBA_fnc_addBISEventHandler;
    }, false] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_veh;
["ace_killed", btc_mil_fnc_unit_killed] call CBA_fnc_addEventHandler;
["ace_repair_setWheelHitPointDamage", btc_rep_fnc_wheelChange] call CBA_fnc_addEventHandler;
["ace_disarming_dropItems", btc_rep_fnc_foodRemoved] call CBA_fnc_addEventHandler;
["btc_respawn_player", {
    params ["", "_player"];
    [btc_rep_malus_player_respawn, _player] call btc_rep_fnc_change;
    btc_slots_serialized set [
        _player getVariable ["btc_slot_key", [0, 0, 0]],
        [] // Reset serialized data if slot died
    ];
}] call CBA_fnc_addEventHandler;

["ace_explosives_detonate", {
    params ["_player", "_explosive", "_delay"];
    [
        btc_door_fnc_broke,
        ([3, _explosive, 0.5] call btc_door_fnc_get) + [_player, 1, 2],
        _delay
    ] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

addMissionEventHandler ["PlayerConnected", btc_eh_fnc_playerConnected];
addMissionEventHandler ["HandleDisconnect", {
    params ["_player"];
    if (_player in (entities "HeadlessClient_F")) then {
        deleteVehicle _player;
    };
    if (alive _player) then {
        _player call btc_slot_fnc_serializeState;
    };
    false
}];
["ace_unconscious", btc_slot_fnc_serializeState] call CBA_fnc_addEventHandler;
["btc_playerConnected", { 
    params ["_player", "_ids"];
    [_player, _player call btc_slot_fnc_createKey, _ids select 4] call btc_slot_fnc_deserializeState_s;
}] call CBA_fnc_addEventHandler;
if (btc_p_auto_db) then {
    addMissionEventHandler ["HandleDisconnect", {
        if ((allPlayers - entities "HeadlessClient_F") isEqualTo []) then {
            [] call btc_db_fnc_save;
        };
    }];
};
if (btc_p_chem) then {
    ["ace_cargoLoaded", btc_chem_fnc_propagate] call CBA_fnc_addEventHandler;
    ["AllVehicles", "GetIn", {[_this select 0, _this select 2] call btc_chem_fnc_propagate}] call CBA_fnc_addClassEventHandler;
    ["DeconShower_01_F", "init", {
        btc_chem_decontaminate pushBack (_this select 0);
        (_this select 0) setVariable ['bin_deconshower_disableAction', true];
    }, true, [], true] call CBA_fnc_addClassEventHandler;
    ["DeconShower_02_F", "init", {
        btc_chem_decontaminate pushBack (_this select 0);
        (_this select 0) setVariable ['bin_deconshower_disableAction', true];
    }, true, [], true] call CBA_fnc_addClassEventHandler;
};

["GroundWeaponHolder", "InitPost", {btc_groundWeaponHolder append _this}] call CBA_fnc_addClassEventHandler;
["acex_fortify_objectPlaced", {[_this select 2] call btc_log_fnc_init}] call CBA_fnc_addEventHandler;
if (btc_p_set_skill) then {
    ["CAManBase", "InitPost", btc_mil_fnc_set_skill] call CBA_fnc_addClassEventHandler;
};
["btc_delay_vehicleInit", btc_patrol_fnc_addEH] call CBA_fnc_addEventHandler;
["ace_killed", {
    params ["_unit"];
    if (side group _unit isNotEqualTo civilian) exitWith {};
    private _vehicle = assignedVehicle _unit;
    if (_vehicle isNotEqualTo objNull) then {
        [[], [_vehicle]] call btc_fnc_delete;
    };
}] call CBA_fnc_addEventHandler;
{
    [_x, "InitPost", {
        [_this select 0, "HandleDamage", btc_patrol_fnc_disabled] call CBA_fnc_addBISEventHandler;
    }, false] call CBA_fnc_addClassEventHandler;
} forEach btc_civ_type_veh;
["ace_tagCreated", btc_tag_fnc_eh] call CBA_fnc_addEventHandler; 

if (btc_p_respawn_ticketsAtStart >= 0) then {
    ["ace_placedInBodyBag", btc_body_fnc_setBodyBag] call CBA_fnc_addEventHandler;

    if !(btc_p_respawn_ticketsShare) then {
        ["btc_playerConnected", btc_respawn_fnc_playerConnected] call CBA_fnc_addEventHandler;
    };

    addMissionEventHandler ["HandleDisconnect", {
        params ["_unit"];
        if (
            ace_respawn_removedeadbodiesdisconnected &&
            _unit in btc_body_deadPlayers
        ) then {
            deleteMarker (_unit getVariable ["btc_body_deadMarker", ""]);
            private _deadUnits  = [[[_unit]] call btc_body_fnc_get] call btc_body_fnc_create;
            private _deadUnit = _deadUnits select 0;
            btc_body_deadPlayers pushBack _deadUnit;
        };
    }];
};

//Cargo
[btc_fob_mat, "InitPost", {
    params ["_obj"];
    [_obj, -1] call ace_cargo_fnc_setSpace;
}, true, [], true] call CBA_fnc_addClassEventHandler;
{
    [_x, "InitPost", {
        params ["_obj"];
        [_obj, 50] call ace_cargo_fnc_setSpace;
    }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach ["CUP_MTVR_Base", "Truck_01_base_F"];
