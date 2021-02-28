
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_veh_add_respawn

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
        [cursorObject, 30] call btc_fnc_eh_veh_add_respawn;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]],
    ["_time", 30, [0]],
    ["_helo", btc_helo, [[]]],
    ["_p_chem", btc_p_chem, [false]]
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
        [_unit] call btc_fnc_eh_veh_respawn;
    };
}];
if (_p_chem) then {
    _vehicle addEventHandler ["GetIn", {
        [_this select 0, _this select 2] call btc_fnc_chem_propagate;
        _this
    }];
};
