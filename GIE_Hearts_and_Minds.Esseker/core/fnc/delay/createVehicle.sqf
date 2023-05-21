
/* ----------------------------------------------------------------------------
Function: btc_delay_fnc_createVehicle

Description:
    Create vehicle and crew when all previous units have been created. btc_delay_time define the time (in second) when the vehicle and crew will be created.

Parameters:
    _group - Group to store crews. [Group]
    _vehicle_type - Vehicle type. [String]
    _units_type - Array of unit type will be use to fill the vehicle. [Array]
    _position - Position of creation. [Array]
    _direction - Direction of spawn. [Number]
    _fuel - Fuel level. [Array]
    _surfaceNormal - Surface normal. [Array]

Returns:
    _delay_vehicle - Delay for unit creation. [Number]

Examples:
    (begin example)
        [createGroup (side player), "O_G_Van_01_transport_F", (btc_type_units + btc_type_units) select [0, ["O_G_Van_01_transport_F",true] call BIS_fnc_crewCount], player getPos [10, direction player]] call btc_delay_fnc_createVehicle;
        [createGroup (side player), "B_Heli_Transport_01_camo_F", (btc_type_units + btc_type_units) select [0, ["B_Heli_Transport_01_camo_F",true] call BIS_fnc_crewCount], player getPos [10, direction player]] call btc_delay_fnc_createVehicle;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

btc_delay_time = btc_delay_time + btc_delay_vehicle;

[{
    btc_delay_time = btc_delay_time - btc_delay_vehicle;

    params [
        ["_group", grpNull, [grpNull]],
        ["_vehicle_type", "", [""]],
        ["_units_type", [], [[]]],
        ["_position", [0, 0, 0], [[]]],
        ["_direction", 0, [0]],
        ["_fuel", 1, [0]],
        ["_surfaceNormal", [], [[]]]
    ];

    private _isAir = _vehicle_type isKindOf "Air";
    private _veh = createVehicle [_vehicle_type, _position, [], 0, ["CAN_COLLIDE", "FLY"] select _isAir];
    if !(_isAir) then {
        _veh setDir _direction;
        if (_surfaceNormal isEqualTo []) then {
            _surfaceNormal = surfaceNormal position _veh;
        };
        _veh setVectorUp _surfaceNormal;
    };
    _veh setFuel _fuel;
    [_veh, "", []] call BIS_fnc_initvehicle;

    ["driver", "commander", "gunner", "turret", "cargo"] apply {count (fullCrew [_veh, _x, true]);} params ["_driverCount", "_commanderCount", "_gunnerCount", "_turretCount", "_cargoCount"];
    private _crews = _driverCount + _commanderCount + _gunnerCount;
    private _numberOfUnits = count _units_type;
    for "_i" from 0 to ((_crews min _numberOfUnits) - 1) do {
        private _unit = _group createUnit [_units_type select _i, _position, [], 0, "CAN_COLLIDE"];

        if (_veh emptyPositions "driver" > 0) then {
            _unit moveinDriver _veh;
            _unit assignAsDriver _veh;
        } else {
            if (_veh emptyPositions "gunner" > 0) then {
                _unit moveinGunner _veh;
                _unit assignAsGunner _veh;
            } else {
                if (_veh emptyPositions "commander" > 0) then {
                    _unit moveinCommander _veh;
                    _unit assignAsCommander _veh;
                };
            };
        };
    };
    _group selectLeader (driver _veh);
    (units _group) joinSilent _group;

    private _crews_and_turret = _crews + _turretCount + _cargoCount;
    for "_i" from _crews to ((_crews_and_turret min _numberOfUnits) - 1) do {
        [_group, _units_type select _i, _position, "CAN_COLLIDE", _veh] call btc_delay_fnc_createUnit;
    };

    ["btc_delay_vehicleInit", [_veh, _group]] call CBA_fnc_localEvent;
}, _this, btc_delay_time - 0.01] call CBA_fnc_waitAndExecute;

count (_this select 2) * btc_delay_unit
