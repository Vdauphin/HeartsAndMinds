
/* ----------------------------------------------------------------------------
Function: btc_int_fnc_orders_give

Description:
    Send order to units

Parameters:
    _units - Units. [Array]
    _dir - Direction of the order. [Number]
    _order - Type of order. [Number]
    _wp_pos - Position to reach (taxi). [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_int_fnc_orders_give;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_units", [], [[]]],
    ["_dir", 0, [0]],
    ["_order", 0, [0]],
    ["_wp_pos", [], [[]]]
];

_units = _units select {!(group _x getVariable ["suicider", false]) && ((side _x) isEqualTo civilian)};

{
    private _wp_pos_i = if ((_order isEqualTo 3) && (_wp_pos isEqualTo [])) then {
        [getPos _x, 200, _dir, 40] call CBA_fnc_randPos
    } else {
        _wp_pos
    };
    [_x, _order, _wp_pos_i] remoteExec ["btc_int_fnc_orders_behaviour", _x];
} forEach _units;

true
