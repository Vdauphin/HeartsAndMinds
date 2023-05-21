
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_wheelChange

Description:
    Change reputation when a player change a wheel of a civilian car.

Parameters:
    _object - Vehicle. [Object]
    _hitPoint - Hitpoint. [String]
    _damage - Damage value. [Number]

Returns:

Examples:
    (begin example)
        [cursorObject, "", 1] call btc_rep_fnc_wheelChange;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    "_object",
    "_hitPoint",
    "_damage"
];

if (
    _damage < 1 ||
    {_object in btc_veh_respawnable} ||
    {_object in btc_vehicles} ||
    {getNumber(configOf _object >> "side") isNotEqualTo 3}
) exitWith {};

private _instigator = nearestObject [_object, btc_player_type];
[
    btc_rep_malus_wheelChange,
    _instigator
] call btc_rep_fnc_change;

if (btc_debug_log) then {
    [format ["THIS = %1 _instigator = %2", _this, _instigator], __FILE__, [false]] call btc_debug_fnc_message;
};
