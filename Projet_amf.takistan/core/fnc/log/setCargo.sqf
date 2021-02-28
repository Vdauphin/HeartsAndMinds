
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_setCargo

Description:
    Clear cargo of all item weapon.

Parameters:
    _object - Object which cargo will be cleared. [Object]

Returns:

Examples:
    (begin example)
        [vehicle player] call btc_fnc_log_setCargo;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_objects", objNull, [objNull]],
    ["_inventory", [], [[]]]
];

clearWeaponCargoGlobal _objects;
clearItemCargoGlobal _objects;
clearMagazineCargoGlobal _objects;

_inventory params [
    ["_weap_obj", [], [[]]],
    ["_mags_obj", [], [[]]],
    ["_items_obj", [], [[]]]
];

{
    _objects addWeaponCargoGlobal [_x, (_weap_obj select 1) select _forEachIndex];
} forEach (_weap_obj select 0);

{
    _objects addMagazineCargoGlobal [_x, (_mags_obj select 1) select _forEachIndex];
} forEach (_mags_obj select 0);

{
    _objects addItemCargoGlobal [_x, (_items_obj select 1) select _forEachIndex];
} forEach (_items_obj select 0);
