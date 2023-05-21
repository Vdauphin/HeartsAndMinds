
/* ----------------------------------------------------------------------------
Function: btc_fnc_delete

Description:
    Delete markers and the JIP remoteExec associated. Delete objects when player is far from them.

Parameters:
    _markers - Array of marker to delete. [Array]
    _objects - Array of objects and or groups to delete. [Array]

Returns:

Examples:
    (begin example)
        [["mymarker"], [objNull, grpNull]] call btc_fnc_delete;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_markers", [], [[""]]],
    ["_objects", [], [[]]]
];

{
    deleteMarker _x;
    //remove JIP remoteExec
    remoteExecCall ["", _x];
} forEach _markers;

[_objects] call btc_fnc_deleteEntities;
