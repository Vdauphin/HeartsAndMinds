
/* ----------------------------------------------------------------------------
Function: btc_fnc_cache_hd_cache

Description:
    Destroy an ammo cache only when an explposive with damage > 0.6 is used.

Parameters:
    _cache - Object to destroy. [Object]
    _part - Not use. [String]
    _damage - Amount of damage get by the object. [Number]
    _injurer - Not use. [Object]
    _ammo - Type of ammo use to make damage. [String]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_cache_hd_cache;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_cache", objNull, [objNull]],
    ["_part", "", [""]],
    ["_damage", 0, [0]],
    ["_injurer", objNull, [objNull]],
    ["_ammo", "", [""]]
];

private _explosive = (getNumber(configFile >> "cfgAmmo" >> _ammo >> "explosive") > 0);

if (isNil {_cache getVariable "btc_hd_cache"} && {_explosive} && {_damage > 0.6}) then {

    if (!isServer) exitWith {
        [_cache, "HandleDamage", "btc_fnc_cache_hd_cache"] call btc_fnc_eh_removePersistOnLocalityChange;
        _this remoteExecCall ["btc_fnc_cache_hd_cache", 2];
    };

    _cache setVariable ["btc_hd_cache", true];

    //Effects
    private _pos = getPosATL btc_cache_obj;
    "Bo_GBU12_LGB_MI10" createVehicle _pos;
    [_pos] spawn {
        params ["_pos"];

        sleep random [0.5, 2, 3];
        "M_PG_AT" createVehicle _pos;
        sleep random [0.5, 2, 3];
        "M_Titan_AT" createVehicle _pos;
    };
    [_pos] call btc_fnc_deaf_earringing;
    [attachedObjects _cache, btc_cache_obj, btc_cache_markers] call CBA_fnc_deleteEntity;

    private _marker = createMarker [format ["btc_cache_%1", btc_cache_n], btc_cache_pos];
    _marker setMarkerType "hd_destroy";
    [_marker, "STR_BTC_HAM_O_EH_HDCACHE_MRK", btc_cache_n] remoteExecCall ["btc_fnc_set_markerTextLocal", [0, -2] select isDedicated, _marker]; //Cached %1 destroyed

    _marker setMarkerSize [1, 1];
    _marker setMarkerColor "ColorRed";

    if (btc_debug_log) then {
        [format ["DESTROYED: ID %1 POS %2", btc_cache_n, btc_cache_pos], __FILE__, [false]] call btc_fnc_debug_message;
    };

    btc_rep_bonus_cache call btc_fnc_rep_change;

    //Notification
    [0] remoteExecCall ["btc_fnc_show_hint", 0];

    [btc_cache_n + 1, btc_cache_pictures] call btc_fnc_cache_init;
} else {
    0
};
