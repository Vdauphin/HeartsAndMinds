
/* ----------------------------------------------------------------------------
Function: btc_int_fnc_orders

Description:
    Send order to a unit or multiple units.

Parameters:
    _order - Type of order [Number]
    _unit - Unit targeted or not. [Object]
    _radius - Radius of units search. [Number]
    _vehicle - Who sent the order, player or vehicle. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_int_fnc_orders;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_order", 0, [0]],
    ["_unit", objNull, [objNull]],
    ["_radius", btc_int_ordersRadius, [0]],
    ["_vehicle", player, [objNull]]
];

if (_vehicle isEqualTo player) then {
    private _gesture = ["", "gestureFreeze", "gestureCover", "gestureGo", "gestureGo"] select _order;
    _vehicle playActionNow _gesture;
};

private _pos = getPos _vehicle;
private _dir = getDir _vehicle;
private _units = (_pos nearEntities [["Car", "Civilian_F"] + btc_civ_type_units, _radius]) apply {driver _x};

if (_units isEqualTo []) exitWith {true};

if (isNull _unit) then {
    [_units, _dir, _order] remoteExecCall ["btc_int_fnc_orders_give", 2];
} else {
    if (_order isEqualTo 4) then {

        btc_int_ask_data = nil;
        ["btc_global_reputation"] remoteExecCall ["btc_int_fnc_ask_var", 2];

        [{!(isNil "btc_int_ask_data")}, {
            params ["_unit", "_pos"];
            private _rep = btc_int_ask_data;

            if (_rep >= btc_rep_level_normal) then {
                [name _unit, localize "STR_BTC_HAM_CON_INT_ORDERS_SHOWMAP"] call btc_fnc_showSubtitle;
                openMap true;
                addMissionEventHandler ["MapSingleClick", 
                    {
                        params ["_units", "_pos"];
                        private _unit = _thisArgs select 0;
                        if (surfaceIsWater _pos) then {
                            [name _unit, localize "STR_BTC_HAM_CON_INT_ORDERS_ONLAND"] call btc_fnc_showSubtitle;
                        } else {
                            [[_unit], 0, 4, _pos] remoteExecCall ["btc_int_fnc_orders_give", _unit];
                            removeMissionEventHandler ["MapSingleClick", _thisEventHandler];
                            openMap false;
                            private _textMap = selectRandom [
                                    localize "STR_BTC_HAM_CON_INT_ORDERS_TAXI_OK1",
                                    localize "STR_BTC_HAM_CON_INT_ORDERS_TAXI_OK2",
                                    localize "STR_BTC_HAM_CON_INT_ORDERS_TAXI_OK3"
                            ];
                            [name _unit, _textMap] call btc_fnc_showSubtitle;
                        };
                    },
                    [_unit]
                ];
            } else {
                if !(player getVariable ["interpreter", false]) exitWith {
                    [name _unit, localize "STR_BTC_HAM_CON_INFO_ASKREP_NOINTER"] call btc_fnc_showSubtitle;
                };

                private _text = selectRandom [
                    localize "STR_BTC_HAM_CON_INT_ORDERS_NEG1",
                    localize "STR_BTC_HAM_CON_INT_ORDERS_NEG2",
                    localize "STR_BTC_HAM_CON_INT_ORDERS_NEG3",
                    localize "STR_BTC_HAM_CON_INT_ORDERS_NEG4"
                ];
                [name _unit, _text] call btc_fnc_showSubtitle;
            };
        }, [_unit, _pos]] call CBA_fnc_waitUntilAndExecute;
    } else {
        [[_unit], _dir, _order] remoteExecCall ["btc_int_fnc_orders_give", _unit];
    };
};
