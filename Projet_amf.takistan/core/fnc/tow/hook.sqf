
/* ----------------------------------------------------------------------------
Function: btc_fnc_tow_hook

Description:
    Save the vehicle selected.

Parameters:
    _towed - Vehicle will be towed. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fnc_tow_hook;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_towed", objNull, [objNull]]
];

btc_log_vehicle_selected = _towed;

private _string_array = "";
{
    _string_array = _string_array + ", " + _x;
} forEach (([_towed] call btc_fnc_log_get_nottowable) - ["Truck_F"]);

(format [localize "STR_BTC_HAM_LOG_HOOK_HINFO", _string_array]) call CBA_fnc_notify;
