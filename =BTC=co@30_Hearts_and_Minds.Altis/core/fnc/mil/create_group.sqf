
/* ----------------------------------------------------------------------------
Function: btc_mil_fnc_create_group

Description:
    Fill me when you edit me !

Parameters:
    _city - [Number]
    _area - [Number]
    _n - [Number]
    _wp - [Array]
    _type_divers - [Array]
    _type_units - [Boolean]
    _p_sea - [Side]
    _enemy_side - [Array]

Returns:

Examples:
    (begin example)
        [player, 50, 1, 1] call btc_mil_fnc_create_group;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull, []]],
    ["_area", 300, [0]],
    ["_n", 0, [0]],
    ["_wp", 0, [0]],
    ["_type_divers", btc_type_divers, [[]]],
    ["_type_units", btc_type_units, [[]]],
    ["_p_sea", btc_p_sea, [true]],
    ["_enemy_side", btc_enemy_side, [east]]
];

private _pos = [_city call CBA_fnc_getPos, _area, _p_sea] call btc_fnc_randomize_pos;
private _group_structure = [1, objNull];
if (_wp isEqualTo 0) then { // Find building
    ([_pos, _n] call btc_mil_fnc_getBuilding) params ["_numberOfGroup", "_structure"];
    if (_structure isNotEqualTo objNull) then {
        _group_structure = [_numberOfGroup, _structure];
    } else {
        _wp = 1; // Handle the case there is no building
    };
};

_group_structure params ["_numberOfGroup", "_structure"];
private _pos_iswater = surfaceIsWater _pos;
private _hashMapGroup = createHashMap;
_hashMapGroup set ["_pos", _pos];
if (
    _structure isEqualTo objNull &&
    {!_pos_iswater}
) then {
    [_hashMapGroup, {
        private _pos = _this get "_pos";
        private _newPos = _pos findEmptyPosition [0, 40, "B_soldier_AR_F"];
        if (_newPos isNotEqualTo []) then {
            _pos = _newPos;
        };
        _pos = [_pos] call btc_fnc_findPosOutsideRock;
        _this set ["_pos", _pos];
    }] call btc_delay_fnc_exec;
};

private _groups = [];
for "_i" from 1 to _numberOfGroup do {
    private _group = createGroup _enemy_side;
    _groups pushBack _group;
    if (_city isEqualType objNull) then {
        _group setVariable ["btc_city", _city];
    };

    switch (_wp) do {
        case (0) : {
            _n = 1;
            [_group, _structure] call btc_fnc_house_addWP;
            _group setVariable ["btc_inHouse", typeOf _structure];
        };
        case (1) : {
            [{
                params ["_group", "_hashMapGroup", "_area"];
                [_group, _hashMapGroup get "_pos", _area, 2 + floor (random 4), "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "", [5, 10, 20]] call CBA_fnc_taskPatrol;
            }, [_group, _hashMapGroup, _area], btc_delay_time] call CBA_fnc_waitAndExecute;
        };
        case (2) : {
            [_group] call CBA_fnc_clearWaypoints;
            [{
                params ["_group", "_hashMapGroup"];
                [_group, _hashMapGroup get "_pos", -1, "SENTRY", "AWARE", "RED"] call CBA_fnc_addWaypoint;
            }, [_group, _hashMapGroup], btc_delay_time] call CBA_fnc_waitAndExecute;            
        };
    };
    [_group, _hashMapGroup, _n, _pos_iswater] call btc_mil_fnc_createUnits;
};

if (btc_debug_log) then {
    [format ["_this = %1 ; POS %2 UNITS N %3", _this, _pos, _n], __FILE__, [false]] call btc_debug_fnc_message;
};

_groups
