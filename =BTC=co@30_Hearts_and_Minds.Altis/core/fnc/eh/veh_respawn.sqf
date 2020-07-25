
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_veh_respawn

Description:
    Respawn the vehicle passed in parameter.

Parameters:
    _vehicle - Vehicle to respawn. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fnc_eh_veh_respawn;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]]
];

private _data = _vehicle getVariable ["data_respawn", []];

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
            ["_supplyVehicle", [], [[]]]
        ];

        private _vehicle = _type createVehicle _pos;
        _vehicle setDir _dir;
        _vehicle setPosASL _pos;
        _vehicle setVectorDirAndUp _vectorPos;
        
        if (getNumber(configFile >> "CfgVehicles" >> _type >> "isUav") isEqualTo 1) then {
            createVehicleCrew _vehicle;
        };

        [_vehicle, _customization, _isMedicalVehicle, _isRepairVehicle, _fuelSource, _pylons, _isContaminated, _supplyVehicle] call btc_fnc_setVehProperties;

        [_vehicle, _time] call btc_fnc_eh_veh_add_respawn;
    }, _data, 1] call CBA_fnc_waitAndExecute;
}, [_vehicle, _data], _data select 3] call CBA_fnc_waitAndExecute;
