
/* ----------------------------------------------------------------------------
Function: btc_fnc_checkArea

Description:
    Check if the area is clear.

Parameters:
    _create_obj - Object to check around. [Object]
    _distance - Distance around the object. [Number]

Returns:
    _isNotClear - Is not clear. [Boolean]

Examples:
    (begin example)
        _isNotClear = [btc_log_create_obj] call btc_fnc_checkArea;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_create_obj", objNull, [objNull]],
    ["_distance", 5, [0]]
];

if ({
    !(
        _x isKindOf "Animal" ||
        _x isKindOf "Module_F" ||
        _x isKindOf "WeaponHolder" ||
        _x isKindOf "DeconShower_01_sound_F"
    )} count (nearestObjects [_create_obj, ["All"], _distance]) > 1) exitWith {
    (localize "STR_BTC_HAM_LOG_BASICS_CLEARAREA") call CBA_fnc_notify;
    true
};

false
