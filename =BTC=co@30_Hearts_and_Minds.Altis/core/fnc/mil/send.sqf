
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_send

Description:
    Send a group of units to a location then call btc_fnc_data_add_group. If player is around, initiate patrol around the destination, ifnot save in database and delete units.

Parameters:
    _start - Starting point. [Object]
    _dest - Destination. [Array, Object]
    _typeOf_patrol - Infantry or motorized. [String]
    _veh_type - Vehicle type for motorized. [String]
    _infFormation - Define the infantry formation. [String]

Returns:
    _group - Created group. [Group]

Examples:
    (begin example)
        [(allPlayers#0), getPos (allPlayers#0), 1, selectRandom btc_type_motorized] call btc_fnc_mil_send
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_start", objNull, [objNull]],
    ["_dest", [0, 0, 0], [[], objNull]],
    ["_typeOf_patrol", 0, [0]],
    ["_veh_type", "", [""]],
    ["_infFormation", "COLUMN", [""]]
];

private _pos = getPos _start;

private _group = grpNull;
private _delay = 0;
switch (_typeOf_patrol) do {
    case 0 : {
        _group = ([_pos, 150, 3 + round random 6, 1] call btc_fnc_mil_create_group) select 0;
        _group setVariable ["no_cache", true];
        [_group] call CBA_fnc_clearWaypoints;
    };
    case 1 : {
        _group = createGroup btc_enemy_side;
        _group setVariable ["no_cache", true];
        [_group] call CBA_fnc_clearWaypoints;

        if (_veh_type isEqualTo "") then {_veh_type = selectRandom btc_type_motorized};
        private _return_pos = [_pos, 10, 500, 13, false] call btc_fnc_findsafepos;

        _delay = [_group, _return_pos, _veh_type] call btc_fnc_mil_createVehicle;
    };
};

[{
    params ["_group", "_typeOf_patrol", "_dest", "_infFormation"];

    switch (_typeOf_patrol) do {
        case 0 : {
            [_group, _dest, -1, "MOVE", "AWARE", "RED", "FULL", _infFormation, "(group this) call btc_fnc_data_add_group;", nil, 60] call CBA_fnc_addWaypoint;
        };
        case 1 : {
            [_group, _dest, -1, "MOVE", "AWARE", "RED", "NORMAL", "NO CHANGE", "(group this) call btc_fnc_data_add_group;", nil, 60] call CBA_fnc_addWaypoint;
        };
    };

    [[_group]] call btc_fnc_set_groupsOwner;

    _group deleteGroupWhenEmpty true;
}, [_group, _typeOf_patrol, _dest, _infFormation], btc_delay_createUnit + _delay] call CBA_fnc_waitAndExecute;

_group
