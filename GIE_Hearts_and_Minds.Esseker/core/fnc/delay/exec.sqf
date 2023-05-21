
/* ----------------------------------------------------------------------------
Function: btc_delay_fnc_exec

Description:
    Execute a function when all previous units have been created.

Parameters:
    _parameters - Parameters to the function. [Array]
    _code - Code to execute. [Code]

Returns:

Examples:
    (begin example)
        [[btc_city_all get 0, 100], btc_ied_fnc_drone_create] call btc_delay_fnc_exec;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

btc_delay_time = btc_delay_time + btc_delay_exec;

[{
    btc_delay_time = btc_delay_time - btc_delay_exec;

    params [
        "_parameters",
        ["_code", {}, [{}]]
    ];

    _parameters call _code;
}, _this, btc_delay_time - 0.01] call CBA_fnc_waitAndExecute;
