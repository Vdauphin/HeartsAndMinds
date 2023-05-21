
/* ----------------------------------------------------------------------------
Function: btc_civ_fnc_get_grenade

Description:
    Search for civilians at a position in a range to add grenade to their inventory.

Parameters:
    _pos - Position to search for civilians. [Array]
    _range - Range to find civilians around the position. [Number]
    _units - Pass directly units to add greande. [Array]

Returns:

Examples:
    (begin example)
        [[0, 0, 0], 200] call btc_civ_fnc_get_grenade;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_range", 300, [0]],
    ["_units", [], [[]]]
];

if (_units isEqualTo []) then {
    _units = _pos nearEntities [btc_civ_type_units, _range];
};

_units = _units select {
    side group _x isEqualTo civilian &&
    {!(lifeState _x in ["INCAPACITATED", "DEAD"])}
};

if (_units isEqualTo []) exitWith {};

{
    if (btc_debug_log) then {
        [format ["%1 - %2", _x, side _x], __FILE__, [false]] call btc_debug_fnc_message;
    };

    [_x] call btc_civ_fnc_add_grenade;

    private _group = createGroup [btc_enemy_side, true];
    _group setVariable ["btc_city", group _x getVariable ["btc_city", objNull]];
    [_x] joinSilent _group;

    [_group] call CBA_fnc_clearWaypoints;
    _group setVariable ["getWeapons", true];
    [_group, _pos, -1, "GUARD", "AWARE", "RED", nil, nil, nil, nil, 10] call CBA_fnc_addWaypoint;
} forEach [selectRandom _units];
