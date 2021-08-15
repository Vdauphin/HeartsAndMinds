
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

[
    getMagazineCargo _object,
    weaponsItemsCargo _object,
    itemCargo _object,
    _everyContainer
]
