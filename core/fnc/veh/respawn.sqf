
/* ----------------------------------------------------------------------------
Function: btc_fnc_veh_respawn

Description:
    Respawn the vehicle passed in parameter.

Parameters:
    _vehicle - Vehicle object. [Object]
    _killer - Killer. [Object]
    _instigator - Person who pulled the trigger. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fnc_veh_respawn;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]],
    ["_killer", objNull, [objNull]],
    ["_instigator", objNull, [objNull]]
];

private _data = _vehicle getVariable ["data_respawn", []];
_data pushBack (_vehicle getVariable ["btc_EDENinventory", []]);

[{
    params [
        "_vehicle",
        "_data",
        ["_helo", btc_helo, [[]]]
    ];

    deleteVehicle _vehicle;
    _helo deleteAt (_helo find _vehicle);

    [{
        params [
            "_type",
            "_pos",
            "_dir",
            "_time",
            ["_vectorPos", [], [[]]],
            ["_customization", [false, false], [[]]],
            ["_isMedicalVehicle", false, [true]],
            ["_isRepairVehicle", false, [true]],
            ["_fuelSource", [], [[]]],
            ["_pylons", [], [[]]],
            ["_isContaminated", false, [false]],
            ["_supplyVehicle", [], [[]]],
            ["_EDENinventory", [], [[]]]
        ];

        private _vehicle = _type createVehicle _pos;
        _vehicle setDir _dir;
        _vehicle setPosASL _pos;
        _vehicle setVectorDirAndUp _vectorPos;

        if (getNumber(configFile >> "CfgVehicles" >> _type >> "isUav") isEqualTo 1) then {
            createVehicleCrew _vehicle;
        };

        [_vehicle, _customization, _isMedicalVehicle, _isRepairVehicle, _fuelSource, _pylons, _isContaminated, _supplyVehicle] call btc_fnc_setVehProperties;
        if !(_EDENinventory isEqualTo []) then {
            _vehicle setVariable ["btc_EDENinventory", _EDENinventory];
            [_vehicle, _EDENinventory] call btc_fnc_log_setCargo;
        };

        [_vehicle, _time] call btc_fnc_veh_addRespawn;
    }, _data, 1] call CBA_fnc_waitAndExecute;
}, [_vehicle, _data], _data select 3] call CBA_fnc_waitAndExecute;

if (isServer) then {
    [btc_rep_malus_veh_killed, _instigator] call btc_fnc_rep_change;
} else {
    [btc_rep_malus_veh_killed, _instigator] remoteExecCall ["btc_fnc_rep_change", 2];
};
