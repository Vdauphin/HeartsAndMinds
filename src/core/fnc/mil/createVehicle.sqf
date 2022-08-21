
/* ----------------------------------------------------------------------------
Function: btc_mil_fnc_createVehicle

Description:
    Create a vehicle with desired crews.

Parameters:
    _group - Group to store crews. [Group]
    _pos - Position of creation. [Array]
    _veh_type - Vehicle type. [String]
    _dir - Direction of spawn. [Number]
    _type_units - Array of available unit type for cargo. [Array]
    _type_divers - Units used for submarine. [Array]
    _type_crewmen - Array of available crews type. [Array]
    _surfaceNormal - Surface normal. [Array]

Returns:
    _delay_vehicle - Delay for unit creation. [Number]

Examples:
    (begin example)
        [createGroup [btc_enemy_side, true], player getPos [10, direction player]] call btc_mil_fnc_createVehicle;
    (end)
    (begin example)
        [createGroup [btc_enemy_side, true], player getPos [10, direction player], "O_G_Van_02_vehicle_F"] call btc_mil_fnc_createVehicle;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if (canSuspend) exitWith {[btc_mil_fnc_createVehicle, _this] call CBA_fnc_directCall};

params [
    ["_group", grpNull, [grpNull]],
    ["_pos", [0, 0, 0], [[]]],
    ["_veh_type", selectRandom btc_type_motorized, [""]],
    ["_dir", 0, [0]],
    ["_surfaceNormal", [], [[]]],
    ["_type_units", btc_type_units, [[]]],
    ["_type_divers", btc_type_divers, [[]]],
    ["_type_crewmen", btc_type_crewmen, [[]]]
];

private _needdiver = getText (configFile >> "CfgVehicles" >> _veh_type >> "simulation") isEqualTo "submarinex";
_type_crewmen = [_type_crewmen, _type_divers select 0] select _needdiver;

private _units_type = [];
private _crewSeats = [_veh_type, false] call BIS_fnc_crewCount;
private _totalSeats = [_veh_type, true] call BIS_fnc_crewCount;
for "_i" from 0 to (_crewSeats - 1) do {
    _units_type pushBack _type_crewmen
};
for "_i" from _crewSeats to (_totalSeats - 1) do {
    _units_type pushBack selectRandom _type_units;
};

[_group, _veh_type, _units_type, _pos, _dir, 1, _surfaceNormal] call btc_delay_fnc_createVehicle
