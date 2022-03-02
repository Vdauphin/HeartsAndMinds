
/* ----------------------------------------------------------------------------
Function: btc_veh_fnc_addRespawn

Description:
    Add a vehicle to the respawn system and save vehicle parameters.

Parameters:
    _vehicle - Vehicle to add inside the respawn system. [Object]
    _time - Time before respawn. [Number]

Returns:
    _handle - Value of the MPEventhandle. [Number]

Examples:
    (begin example)
        [cursorObject, 30] remoteExecCall ["btc_veh_fnc_addRespawn", 2];
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]],
    ["_time", 30, [0]]
];

if (isNil "btc_veh_respawnable") then {
    btc_veh_respawnable = [];
};
if (isNil {_vehicle getVariable "btc_EDENinventory"}) then {
    _vehicle setVariable ["btc_EDENinventory", _vehicle call btc_log_fnc_inventoryGet];
};

if (btc_veh_respawnable pushBackUnique _vehicle isEqualTo -1) exitWith {
    if (btc_debug || btc_debug_log) then {
        ["Vehicle added more than once in btc_veh_respawnable", __FILE__, [btc_debug, btc_debug_log, true]] call btc_debug_fnc_message;
    }; 
};

private _type = typeOf _vehicle;
private _pos = getPosASL _vehicle;
private _dir = getDir _vehicle;
private _vector = [vectorDir _vehicle, vectorUp _vehicle];
private _vehProperties = _vehicle call btc_veh_fnc_propertiesGet;

// Reset properties
_vehProperties set [5, false];
(_vehProperties select 3) set [0, getNumber (configOf _veh >> "ace_refuel_fuelCargo")];
(_vehProperties select 6) set [1, getNumber (configOf _veh >> "ace_rearm_defaultSupply")];

_vehicle setVariable ["data_respawn", [_type, _pos, _dir, _time, _vector] + _vehProperties];
_vehicle setVariable ["btc_dont_delete", true];

if ((isNumber (configOf _vehicle >> "ace_fastroping_enabled")) && (typeOf _vehicle isNotEqualTo "RHS_UH1Y_d")) then {_vehicle call ace_fastroping_fnc_equipFRIES};
_vehicle addMPEventHandler ["MPKilled", {
    if (isServer) then {
        params ["_vehicle", "_killer", "_instigator"];

        private _data = _vehicle getVariable ["data_respawn", []];
        _data pushBack (_vehicle getVariable ["btc_EDENinventory", []]);
        [btc_veh_fnc_respawn, [_vehicle, _data], _data select 3] call CBA_fnc_waitAndExecute;

        [btc_rep_malus_veh_killed, _instigator] call btc_rep_fnc_change;
    };
}];
if (btc_p_respawn_location > 0) then {
    if (fullCrew [_vehicle, "cargo", true] isNotEqualTo []) then {
        [
            _vehicle,
            "Deleted",
            {_thisArgs call BIS_fnc_removeRespawnPosition},
            [btc_player_side, _vehicle] call BIS_fnc_addRespawnPosition
        ] call CBA_fnc_addBISEventHandler;
    };
};
