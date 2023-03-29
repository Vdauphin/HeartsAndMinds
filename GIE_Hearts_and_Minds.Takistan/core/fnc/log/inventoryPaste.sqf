
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_inventoryPaste

Description:
    Fill me when you edit me !

Parameters:
    _copy_container - [Array]
    _searchLocation - Object to search around. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_log_fnc_inventoryPaste;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_inventory", [], [[]]],
    ["_searchLocation", objNull, [objNull]]
];

private _objects = nearestObjects [_searchLocation, ["AllVehicles", "ThingX"], 3];

if (
    isNil "_inventory" ||
    {flatten _inventory isEqualTo []}
) exitWith {(localize "STR_BTC_HAM_O_PASTE_NOCOPIEDI") call CBA_fnc_notify};
if (_objects isEqualTo []) exitWith {(localize "STR_BTC_HAM_O_COPY_NOOBJECTS") call CBA_fnc_notify};

[_objects select 0, _inventory] call btc_log_fnc_inventorySet;

(localize "str_mission_completed") call CBA_fnc_notify;
