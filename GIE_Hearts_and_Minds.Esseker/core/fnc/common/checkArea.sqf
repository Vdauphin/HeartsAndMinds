
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

if (
    count (nearestObjects [_create_obj, ["LandVehicle", "CAManBase", "Strategic", "ThingX"], _distance]) > 0
) exitWith {
    (localize "STR_BTC_HAM_LOG_BASICS_CLEARAREA") call CBA_fnc_notify;
    true
};

false
