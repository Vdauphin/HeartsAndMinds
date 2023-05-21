
/* ----------------------------------------------------------------------------
Function: btc_mil_fnc_unit_killed

Description:
    Fill me when you edit me !

Parameters:
    _unit - Object the event handler is assigned to. [Object]
    _killer - Object that killed the unit. Contains the unit itself in case of collisions. [Object]
    _instigator - Person who pulled the trigger. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_mil_fnc_unit_killed;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params ["_unit", "_causeOfDeath", "_killer", "_instigator"];

if (side group _unit isNotEqualTo btc_enemy_side) exitWith {};

if (random 100 > btc_info_intel_chance) then {
    _unit setVariable ["intel", true];
};

if (isPlayer _instigator) then {
    [btc_rep_bonus_mil_killed, _instigator] call btc_rep_fnc_change;
};
