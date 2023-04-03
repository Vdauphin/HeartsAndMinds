
/* ----------------------------------------------------------------------------
Function: btc_delay_fnc_waitAndExecute

Description:
    Wait and execute a function with a _delay. Usefull when used after btc_delay_fnc_createVehicle that return a delay.

Parameters:
    _code - Code to execute. [Code]
    _parameters - Parameters to the function. [Array]
    _delay - Delay of execution. [Number]

Returns:

Examples:
    (begin example)
        [{systemChat _this}, "hello", 0] call btc_delay_fnc_waitAndExecute;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

[{
    params [
        ["_code", {}, [{}]],
        ["_parameters", [], [[]]],
        ["_delay", 0, [0]]
    ];

    if (_delay isEqualTo 0) exitWith {_parameters call _code};

    [_code, _parameters, btc_delay_time + _delay] call CBA_fnc_waitAndExecute;
}, _this, btc_delay_time] call CBA_fnc_waitAndExecute;
