/*
    File: fn_create_namespace.sqf
    Author: Spoffy
    Date: 2020-01-29
    Last Update: 2020-01-29
    Public: No

    Description:
        No description added yet.

    Parameter(s):
        _isGlobal - Whether the namespace should only be created globally [Bool, defaults to false]

    Returns:
        A namespace (either a Location if local, or a simpleObject if global) [Object]

    Example(s):
        true call para_g_fnc_create_namespace;
*/

params [["_global", false]];

if (!_global) exitWith {
	createLocation ["Invisible", [-1, -1, -1], 0, 0]
};

createSimpleObject ["a3\weapons_f\empty.p3d", [-1, -1, -1]]
