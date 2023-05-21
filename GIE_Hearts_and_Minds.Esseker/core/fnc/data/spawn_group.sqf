
/* ----------------------------------------------------------------------------
Function: btc_data_fnc_spawn_group

Description:
    Create group previously saved by btc_data_fnc_get_group.

Parameters:
    _data_unit - All data listed above. [Array]
        _type - Type of group (3: in house group, 4: civilian with weapon, 5: suicider ...). [Number]
        _array_pos - Position on units. [Array]
        _array_type - Type of units. [Array]
        _side - Side of the group. [Side]
        _array_dam - Damage of units. [Array]
        _behaviour - Behaviour of units. [Array]
        _array_wp - Waypoints of group. [Array]
        _array_veh - Vehicle occupied by the group. [Array, String]
    _city - City. [Object]
    _spawningRadius - Spawning radius. [Number]

Returns:
    _delay - Delay due to vehicle spawn. [Number]

Examples:
    (begin example)
        _result = [] call btc_data_fnc_spawn_group;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_data_unit", [], [[]]],
    ["_city", objNull, [objNull]],
    ["_spawningRadius", 100, [0]]
];
_data_unit params [
    ["_type", 1, [0]],
    ["_array_pos", [], [[]]],
    ["_array_type", [], [[]]],
    ["_side", east, [east]],
    ["_array_dam", [], [[]]],
    ["_behaviour", [], [[]]],
    ["_array_wp", [], [[]]],
    ["_array_veh", [], [[], ""]]
];

private _delay = 0;
if (_type isEqualTo 5) exitWith {
    [[_city, _spawningRadius, _array_pos select 0, _array_type select 0], btc_ied_fnc_suicider_create] call btc_delay_fnc_exec;
    _delay + btc_delay_unit
};
if (_type isEqualTo 7) exitWith {
    [[_city, _spawningRadius, _array_pos select 0], btc_ied_fnc_drone_create] call btc_delay_fnc_exec;
    _delay + btc_delay_unit
};

private _group = createGroup _side;
_group setVariable ["btc_city", _city];
if (_type isEqualTo 1) then {
    _array_veh params ["_typeOf", "_posATL", "_dir", "_fuel", ["_vectorUp", []]];
    _delay = [_group, _typeOf, _array_type, _posATL, _dir, _fuel, _vectorUp] call btc_delay_fnc_createVehicle;
} else {
    for "_i" from 0 to (count _array_pos - 1) do {
        [_group, _array_type select _i, _array_pos select _i, "CAN_COLLIDE"] call btc_delay_fnc_createUnit;
        //_u setDamage (_array_dam select _i);
    };
};

[{
    params ["_data_unit", "_group"];
    _data_unit params [
        ["_type", 1, [0]],
        ["_array_pos", [], [[]]],
        ["_array_type", [], [[]]],
        ["_side", east, [east]],
        ["_array_dam", [], [[]]],
        ["_behaviour", [], [[]]],
        ["_array_wp", [], [[]]],
        ["_array_veh", [], [[], ""]]
    ];

    if !(_type in [3, 6]) then {
        [_group] call CBA_fnc_clearWaypoints;
        {
            _x params [
                "_position",
                "_type",
                "_speed",
                "_formation",
                "_combat",
                "_behaviour",
                ["_timeout", [0, 0, 0], [[]], 3],
                ["_compRadius", 20, [0]]
            ];
            [_group, _position, -1, _type, _behaviour, _combat, _speed, _formation, "", _timeout, _compRadius] call CBA_fnc_addWaypoint;
        } forEach (_array_wp select 1);
        if (_array_wp select 1 isNotEqualTo []) then {
            _group setCurrentWaypoint [_group, _array_wp select 0];
        };
    };
    if (_type isEqualTo 3) then {
        [_group, nearestObject [_array_pos select 0, _array_veh]] call btc_fnc_house_addWP;
        _group setVariable ["btc_inHouse", _array_veh];
    };
    if (_type isEqualTo 4) then {[[0, 0, 0], 0, units _group] call btc_civ_fnc_get_weapons;};
    if (_type isEqualTo 6) then {
        [_group, _array_veh select 0] call btc_civ_fnc_addWP;
        _group setVariable ["btc_data_inhouse", _array_veh];
    };
}, [_data_unit, _group], _delay] call btc_delay_fnc_waitAndExecute;

_delay
