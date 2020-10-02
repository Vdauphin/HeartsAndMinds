
/* ----------------------------------------------------------------------------
Function: btc_fnc_int_orders_behaviour

Description:
    Fill me when you edit me !

Parameters:
    _unit - [Object]
    _order - [Number]
    _wp_pos - [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_int_orders_behaviour;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_order", 0, [0]],
    ["_wp_pos", [0, 0, 0], [[]]]
];

private _group = group _unit;

if (_order isEqualTo (_unit getVariable ["order", 0])) exitWith {};

_unit setVariable ["order", _order];

if (_unit isEqualTo vehicle _unit) then {
    [_group] call CBA_fnc_clearWaypoints;
};

switch (_order) do {
    case 1 : {
        doStop _unit;
        _unit disableAI "PATH";
    };
    case 2 : {
        doStop _unit;
        _unit disableAI "PATH";
        if (vehicle _unit != _unit) exitWith {};
        [_unit, "", 2] call ace_common_fnc_doAnimation;
        _unit setUnitPos "DOWN";
    };
    case 3 : {
        _unit enableAI "PATH";
        _unit setUnitPos "UP";
        _unit doMove _wp_pos;
    };
    case 4 : {
        _unit enableAI "PATH";
        _unit doMove _wp_pos;
    };
};

if (_order isEqualTo 4) then {
    waitUntil {sleep 3; (isNull _unit || !alive _unit || (_unit inArea [_wp_pos, 10, 10, 0, false]))};
} else {
    waitUntil {sleep 3; (isNull _unit || !alive _unit || (count (getPos _unit nearEntities ["SoldierWB", 50]) isEqualTo 0))};
};

if (isNull _unit || !alive _unit) exitWith {};

if (_order isEqualTo 4) then {
    doStop _unit;
    _unit disableAI "PATH";
    sleep (30 + random 10);
};

_unit setVariable ["order", nil];
_unit setUnitPos "AUTO";
_unit enableAI "PATH";
_unit doMove getPos _unit;

if (_unit isEqualTo vehicle _unit) then {
    [_group] call btc_fnc_civ_addWP;
};
