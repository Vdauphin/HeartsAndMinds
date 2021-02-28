
/* ----------------------------------------------------------------------------
Function: btc_fnc_civ_unit_create

Description:
    Initialize civilian by adding eventhandlers.

Parameters:
    _group - group to initialize. [Object]

Returns:

Examples:
    (begin example)
        [_group] call btc_fnc_civ_unit_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]]
];

{
    _x setVariable ["btc_init", true];

    _x call btc_fnc_rep_add_eh;
} forEach (units _group select {!(_x getVariable ["btc_init", false])});
