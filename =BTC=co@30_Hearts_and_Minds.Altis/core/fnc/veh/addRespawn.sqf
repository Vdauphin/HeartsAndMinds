
/* ----------------------------------------------------------------------------
Function: btc_fnc_veh_addRespawn

Description:
    Add a vehicle to the respawn system and save vehicle parameters.

Parameters:
    _vehicle - Vehicle to add inside the respawn system. [Object]
    _time - Time before respawn. [Number]
    _helo - Array of respawning vehicles. [Array]

Returns:
    _handle - Value of the MPEventhandle. [Number]

Examples:
    (begin example)
        [cursorObject, 30] call btc_fnc_veh_addRespawn;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]],
    ["_time", 30, [0]],
    ["_helo", btc_helo, [[]]]
];

_helo pushBackUnique _vehicle;

private _type = typeOf _vehicle;
private _pos = getPosASL _vehicle;
private _dir = getDir _vehicle;
private _vector = [vectorDir _vehicle, vectorUp _vehicle];
private _vehProperties = [_vehicle] call btc_fnc_getVehProperties;
_vehProperties set [5, false];

_vehicle setVariable ["data_respawn", [_type, _pos, _dir, _time, _vector] + _vehProperties];

if ((isNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "ace_fastroping_enabled")) && !(typeOf _vehicle isEqualTo "RHS_UH1Y_d")) then {[_vehicle] call ace_fastroping_fnc_equipFRIES};
_vehicle addMPEventHandler ["MPKilled", {
    params ["_unit"];
    if (
        isServer &&
        {_unit getVariable ["btc_killed", true]} // https://feedback.bistudio.com/T149510
    ) then {
        _unit setVariable ["btc_killed", false];
        _this call btc_fnc_veh_respawn;
    };
}];
if (btc_p_respawn_location > 0) then {
    if !(fullCrew [_vehicle, "cargo", true] isEqualTo []) then {
        [_vehicle, "Deleted", {_thisArgs call BIS_fnc_removeRespawnPosition}, [btc_player_side, _vehicle] call BIS_fnc_addRespawnPosition] call CBA_fnc_addBISEventHandler;
    };
};
