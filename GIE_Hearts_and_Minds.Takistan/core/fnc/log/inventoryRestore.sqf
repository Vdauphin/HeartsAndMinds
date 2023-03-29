
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_inventoryRestore

Description:
    Fill me when you edit me !

Parameters:
    _searchLocation - Object to search around. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_log_fnc_inventoryRestore;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_searchLocation", objNull, [objNull]]
];

private _objects = nearestObjects [_searchLocation, ["AllVehicles", "ThingX"], 3];

if (_objects isEqualTo []) exitWith {(localize "STR_BTC_HAM_O_COPY_NOOBJECTS") call CBA_fnc_notify};

(_objects select 0) remoteExecCall ["btc_veh_fnc_inventoryRestore", 2];

(localize "str_mission_completed") call CBA_fnc_notify;
