
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_inventorySet

Description:
    Set inventory of an object.

Parameters:
    _object - Object with inventory. [Object]
    _inventory - Inventory to set. [Array]

Returns:

Examples:
    (begin example)
        [cursorObject, [cursorObject] call btc_log_fnc_inventoryGet] call btc_log_fnc_inventorySet;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]],
    ["_inventory", [], [[]]]
];

clearWeaponCargoGlobal _object;
clearItemCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearBackpackCargoGlobal _object;

_inventory params [
    ["_magazines", [], [[]]],
    ["_weapons", [], [[]]],
    ["_items", [], [[]]],
    ["_everyContainer", [], [[]]]
];

{
    _object addMagazineCargoGlobal [_x, (_magazines select 1) select _forEachIndex];
} forEach (_magazines select 0);

{
    _object addWeaponWithAttachmentsCargoGlobal [_x, 1];
} forEach _weapons;

{
    private _containerType = _x select 0;
    if (_containerType in _items) then {
        _object addItemCargoGlobal [_containerType, 1];
        _items deleteAt (_items find _containerType);
    } else {
        _object addBackpackCargoGlobal [_containerType, 1];
    };

    private _newContainer = everyContainer _object;
    [(_newContainer select (count _newContainer -1)) select 1, _x select 1] call btc_log_fnc_inventorySet;
} forEach _everyContainer;

{
    _object addItemCargoGlobal [_x, 1];
} forEach _items;
