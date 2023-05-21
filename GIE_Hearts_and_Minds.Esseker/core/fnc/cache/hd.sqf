
/* ----------------------------------------------------------------------------
Function: btc_cache_fnc_hd

Description:
    Destroy an ammo cache only when an explposive with damage > 0.6 is used.

Parameters:
    _cache - Object to destroy. [Object]
    _part - Not use. [String]
    _damage - Amount of damage get by the object. [Number]
    _injurer - Not use. [Object]
    _ammo - Type of ammo use to make damage. [String]
    _hitIndex - Hit part index of the hit point, -1 otherwise. [Number]
    _instigator - Person who pulled the trigger. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_cache_fnc_hd;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_cache", objNull, [objNull]],
    ["_part", "", [""]],
    ["_damage", 0, [0]],
    ["_injurer", objNull, [objNull]],
    ["_ammo", "", [""]],
    ["_hitIndex", 0, [0]], 
    ["_instigator", objNull, [objNull]]
];

private _explosive = getNumber (configFile >> "cfgAmmo" >> _ammo >> "explosive") > 0;

if (
    !(_cache getVariable ["btc_cache_fnc_hd_fired", false]) &&
    {_explosive} &&
    {_damage > 0.6}
) then {
    _cache setVariable ["btc_cache_fnc_hd_fired", true];

    if (!isServer) exitWith {
        _this remoteExecCall ["btc_cache_fnc_hd", 2];
    };

    //Effects
    private _pos = getPosATL btc_cache_obj;
    "Bo_GBU12_LGB_MI10" createVehicle _pos;
    [{
        "M_PG_AT" createVehicle _this;
        [{
            "M_PG_AT" createVehicle _this;
        }, _this, random [0.5, 2, 3]] call CBA_fnc_waitAndExecute;
    }, _pos, random [0.5, 2, 3]] call CBA_fnc_waitAndExecute;
    [_pos] call btc_deaf_fnc_earringing;
    [attachedObjects _cache, btc_cache_obj, btc_cache_markers] call CBA_fnc_deleteEntity;

    private _marker = createMarker [format ["btc_cache_%1", btc_cache_n], btc_cache_pos];
    _marker setMarkerType "hd_destroy";
    [_marker, "STR_BTC_HAM_O_EH_HDCACHE_MRK", btc_cache_n] remoteExecCall ["btc_fnc_set_markerTextLocal", [0, -2] select isDedicated, _marker]; //Cached %1 destroyed
    _marker setMarkerSize [1, 1];
    _marker setMarkerColor "ColorRed";

    if (btc_debug_log) then {
        [format ["DESTROYED: ID %1 POS %2", btc_cache_n, btc_cache_pos], __FILE__, [false]] call btc_debug_fnc_message;
    };

    [btc_rep_bonus_cache, _instigator] call btc_rep_fnc_change;

    //Notification
    [0] remoteExecCall ["btc_fnc_show_hint", 0];

    [btc_cache_n + 1, btc_cache_pictures] call btc_cache_fnc_init;
} else {
    0
};
