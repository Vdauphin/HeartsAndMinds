
/* ----------------------------------------------------------------------------
Function: btc_civ_fnc_get_weapons

Description:
    Search for civilians at a position in a range to add weapons to their inventory.

Parameters:
    _pos - Position to search for civilians. [Array]
    _range - Range to find civilians around the position. [Number]
    _units - Pass directly units to add weapons. [Array]

Returns:

Examples:
    (begin example)
        [getPos player, 200] call btc_civ_fnc_get_weapons;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_range", 300, [0]],
    ["_units", [], [[]]]
];

if (_units isEqualTo []) then {
    _units = _pos nearEntities [btc_civ_type_units, _range];
    _units = _units select {
        side group _x isEqualTo civilian &&
        {!(lifeState _x in ["INCAPACITATED", "DEAD"])}
    };
};

{
    if (btc_debug_log) then {
        [format ["%1 - %2", _x, side _x], __FILE__, [false]] call btc_debug_fnc_message;
    };

    private _unit = _x;

    [_unit, "", 2] call ace_common_fnc_doAnimation;

    private _playableUnits = playableUnits inAreaArray [getPosWorld _unit, 50, 50];
    private _hgun = _playableUnits findIf {[_x, _unit] call btc_fnc_check_los} != -1;

    private _weapon = selectRandom ([btc_w_civs select 0, btc_w_civs select 1] select _hgun);
    private _magazine = (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0;

    [_unit, _weapon, _magazine] remoteExecCall ["btc_civ_fnc_add_weapons", _unit];

    private _group = createGroup [btc_enemy_side, true];
    _group setVariable ["btc_city", group _unit getVariable ["btc_city", objNull]];
    [_unit] joinSilent _group;
    
    [_group] call CBA_fnc_clearWaypoints;
    _group setVariable ["getWeapons", true];
    [_group, getPos _unit, -1, "GUARD", "AWARE", "RED", nil, nil, nil, nil, 10] call CBA_fnc_addWaypoint;
} forEach _units;
