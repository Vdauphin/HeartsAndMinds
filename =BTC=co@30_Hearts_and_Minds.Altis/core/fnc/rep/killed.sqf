
/* ----------------------------------------------------------------------------
Function: btc_fnc_rep_killed

Description:
    Change reputation when a player kill a unit.

Parameters:
    _unit - Unit killed. [Object]
    _killer - Killer. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, player] call btc_fnc_rep_killed;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params ["_unit", "_causeOfDeath", "_killer", "_instigator"];

if (
    !(side group _unit isEqualTo civilian) &&
    {!isAgent teamMember _unit}
) exitWith {};

if (isPlayer _instigator) then {
    [
        [btc_rep_malus_civ_killed, btc_rep_malus_animal_killed] select (isAgent teamMember _unit),
        _instigator
    ] call btc_fnc_rep_change;
    if (btc_global_reputation < 600) then {
        [getPos _unit] call btc_fnc_rep_eh_effects;
    };

    if (btc_debug_log) then {
        [format ["GREP %1 THIS = %2", btc_global_reputation, _this], __FILE__, [false]] call btc_fnc_debug_message;
    };
};
