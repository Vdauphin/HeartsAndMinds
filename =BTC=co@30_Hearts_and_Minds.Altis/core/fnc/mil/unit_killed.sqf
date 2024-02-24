
/* ----------------------------------------------------------------------------
Function: btc_mil_fnc_unit_killed

Description:
    Handle intel and reputation when an enemy is killed.

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

if (
    isPlayer _instigator ||
    _killer isEqualTo btc_explosives_objectSide ||
    isPlayer _killer
) then {
    private _repValue = btc_rep_bonus_mil_killed;
    if (isNull _instigator && isPlayer _killer) then {
        _instigator = _killer;
    };
    if (
        _unit getVariable ["ace_captives_isHandcuffed", false] ||
        _unit getVariable ["ace_captives_isSurrendering", false]
    ) then {
        if (_causeOfDeath isNotEqualTo "CardiacArrest:Bleedout") then {
            _repValue = btc_rep_malus_mil_killed;
        };
    };
    [_repValue, _instigator] call btc_rep_fnc_change;
};
