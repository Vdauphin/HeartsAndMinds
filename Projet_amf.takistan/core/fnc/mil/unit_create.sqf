
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_unit_create

Description:
    Fill me when you edit me !

Parameters:
    _group - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_mil_unit_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]]
];

{
    _x setVariable ["btc_init", true];
    _x call btc_fnc_mil_add_eh;

    if (btc_p_set_skill) then {
        _x call btc_fnc_mil_set_skill;
    };
} forEach (units _group select {!(_x getVariable ["btc_init", false])});
