/*
    File: fn_delete_namespace.sqf
    Author: Spoffy
    Date: 2020-01-29
    Last Update: 2020-01-29
    Public: No

    Description:
        Deletes a previously created namespace.

    Parameter(s):
        _namespace - Namespace to delete [Location]

    Returns: nothing

    Example(s):
        locationNull call para_g_fnc_delete_namespace;
*/

params ["_namespace"];

if (_namespace isEqualType locationNull) exitWith {
	deleteLocation _namespace;
};

deleteVehicle _namespace;
