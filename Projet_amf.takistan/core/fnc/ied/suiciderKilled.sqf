
/* ----------------------------------------------------------------------------
Function: btc_fnc_ied_suiciderKilled

Description:
    Remove the the suicider flag to the corresponding city.

Parameters:
    _id - ID of the city. [Number]

Returns:

Examples:
    (begin example)
        [0] call btc_fnc_ied_suiciderKilled;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_id", 0, [0]]
];

if (btc_debug || btc_debug_log) then {
    [format ["Suicider killed in city %1", _id], __FILE__, [btc_debug, btc_debug_log]] call btc_fnc_debug_message;
};

if (!isServer) exitWith {
    _this remoteExecCall ["btc_fnc_ied_suiciderKilled", 2];
};

private _city = btc_city_all select _id;
_city setVariable ["has_suicider", false];
