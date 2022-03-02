
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_inventoryGet

Description:
    Get inventory of an object.

Parameters:
    _object - Object with inventory. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_log_fnc_inventoryGet;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]]
];

private _everyContainer = everyContainer _object;
{
    _x set [1, (_x select 1) call btc_log_fnc_inventoryGet];
} forEach _everyContainer;

private _weaponsItemsCargo = weaponsItemsCargo _object;
{
    private _magazine = _x select 4 select 0;
    if (((_magazine call BIS_fnc_itemType) select 1) isEqualTo "UnknownMagazine") then {
        _x set [4, []]; // Remove dummy magazine
    };
} forEach _weaponsItemsCargo;

[
    getMagazineCargo _object,
    _weaponsItemsCargo,
    itemCargo _object,
    _everyContainer
]
