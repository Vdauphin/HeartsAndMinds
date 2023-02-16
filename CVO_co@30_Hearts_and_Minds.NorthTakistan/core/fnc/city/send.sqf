
/* ----------------------------------------------------------------------------
Function: btc_city_fnc_send

Description:
    Send a group of units to a location then call btc_data_fnc_add_group. If player is around, initiate patrol around the destination, ifnot save in database and delete units.

Parameters:
    _dest - Destination. [Array, Object]
    _spawningRadius - Random area for destination. [Number]
    _typeOf_patrol - Infantry or motorized. [String]
    _veh_types - Vehicle types for motorized. [String]
    _sendMultipleGroup - Number of group to send. [Number]

Returns:
    _group - Created group. [Group]

Examples:
    (begin example)
        [allPlayers#0, getPos (allPlayers#0)] call btc_city_fnc_send
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_dest", [0, 0, 0], [[], objNull]],
    ["_spawningRadius", 0, [0]],
    ["_typeOf_patrol", 0, [0]],
    ["_veh_types", [], [[]]],
    ["_sendMultipleGroup", 1, [1]]
];

private _closest = [
    _dest,
    values btc_city_all select {!(_x getVariable ["active", false])},
    false
] call btc_fnc_find_closecity;

for "_i" from 1 to _sendMultipleGroup do {
    [_closest, [_dest, _spawningRadius / 2] call CBA_fnc_randPos, _typeOf_patrol, selectRandom _veh_types] call btc_mil_fnc_send;
};
