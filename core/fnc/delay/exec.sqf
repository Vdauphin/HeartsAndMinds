
/* ----------------------------------------------------------------------------
Function: btc_fnc_delay_exec

Description:
    Execute a function when all previous units have been created.

Parameters:
    _parameters - Parameters to the function. [Array]
    _code - Code to execute. [Code]

Returns:

Examples:
    (begin example)
        [[btc_city_all select 0, 100], btc_fnc_ied_drone_create] call btc_fnc_delay_exec;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

btc_delay_createUnit = btc_delay_createUnit + 0.2;

[{
    params [
        "_parameters",
        ["_code", {}, [{}]]
    ];

    _parameters call _code;

    btc_delay_createUnit = btc_delay_createUnit - 0.2;
}, _this, btc_delay_createUnit - 0.01] call CBA_fnc_waitAndExecute;
