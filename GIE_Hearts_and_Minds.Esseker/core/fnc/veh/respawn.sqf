
/* ----------------------------------------------------------------------------
Function: btc_veh_fnc_respawn

Description:
    Respawn the vehicle passed in parameter.

Parameters:
    _vehicle - Vehicle object. [Object]
    _serialisedVeh - Serialised vehicle. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_veh_fnc_respawn;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]],
    ["_serialisedVeh", [], [[]]]
];

btc_veh_respawnable deleteAt (btc_veh_respawnable find _vehicle);

crew _vehicle call btc_fnc_moveOut;
[{
    crew (_this select 0) isEqualTo []
}, {
    params ["_vehicle", "_serialisedVeh"];

    _vehicle call CBA_fnc_deleteEntity;

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
            ["_objectTexture", [], [[]]],
            ["_EDENinventory", [], [[]]]
        ];

        private _vehicle = _type createVehicle _pos;
        _vehicle setDir _dir;
        _vehicle setPosASL _pos;
        _vehicle setVectorDirAndUp _vectorPos;

        if (unitIsUAV _vehicle) then {
            createVehicleCrew _vehicle;
        };

        [_vehicle, _customization, _isMedicalVehicle, _isRepairVehicle, _fuelSource, _pylons, _isContaminated, _supplyVehicle, _objectTexture] call btc_veh_fnc_propertiesSet;
        if (_EDENinventory isNotEqualTo []) then {
            _vehicle setVariable ["btc_EDENinventory", _EDENinventory];
            [_vehicle, _EDENinventory] call btc_log_fnc_inventorySet;
        };

        [_vehicle, _time] call btc_veh_fnc_addRespawn;
    }, _serialisedVeh, 2] call CBA_fnc_waitAndExecute;
}, [_vehicle, _serialisedVeh]] call CBA_fnc_waitUntilAndExecute;
